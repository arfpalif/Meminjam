import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:meminjam/features/admin/stock/models/loan_model.dart';

class NotificationService extends GetxService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool isInitialized = false;

  bool get isNotificationInitialized => isInitialized;

  @override
  void onInit() {
    super.onInit();
    initNotification();
  }

  Future<void> initNotification() async {
    if (isInitialized) return;

    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initSettingsIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: initSettingsIos,
    );

    await notificationPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    await notificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'meminjam_channel',
        'Meminjam Notifications',
        channelDescription: 'Notifications for loan due dates',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails(),
    );
  }

  Future<void> scheduleLoanNotifications(
    LoanModel loan,
    String itemName,
  ) async {
    final now = DateTime.now();

    final reminderDate = loan.dueDate.subtract(const Duration(days: 1));
    final scheduledReminder = DateTime(
      reminderDate.year,
      reminderDate.month,
      reminderDate.day,
      14,
      52,
    );

    if (scheduledReminder.isAfter(now)) {
      await _scheduleNotification(
        id: loan.id.hashCode,
        title: 'Pengingat Pengembalian',
        body: 'Barang "$itemName" harus dikembalikan besok!',
        scheduledDate: scheduledReminder,
      );
    }

    final overdueDate = DateTime(
      loan.dueDate.year,
      loan.dueDate.month,
      loan.dueDate.day,
      14, // Default to 9 AM
      52,
    );

    if (overdueDate.isAfter(now)) {
      await _scheduleNotification(
        id: (loan.id.hashCode + 1).toUnsigned(31),
        title: 'Batas Waktu Habis',
        body:
            'Barang "$itemName" sudah mencapai batas waktu pengembalian hari ini.',
        scheduledDate: overdueDate,
      );
    }
  }

  Future<void> syncNotifications(
    List<LoanModel> loans,
    Function(String) getItemName,
  ) async {
    for (final loan in loans) {
      if (loan.isActive) {
        final itemName = getItemName(loan.itemId);
        await scheduleLoanNotifications(loan, itemName);
      } else {
        await cancelLoanNotifications(loan.id);
      }
    }
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await notificationPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelLoanNotifications(String loanId) async {
    await notificationPlugin.cancel(id: loanId.hashCode);
    await notificationPlugin.cancel(id: (loanId.hashCode + 1).toUnsigned(31));
  }
}
