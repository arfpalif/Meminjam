import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meminjam/utils/services/notification_service.dart';
import '../models/loan_model.dart';
import '../models/stock_model.dart';
import '../repositories/stock_repository.dart';
import 'package:meminjam/features/admin/chat/repositories/chat_repository.dart';
import 'package:meminjam/configs/routes/route.dart';
import '../../history/repositories/activity_repository.dart';

class StockController extends GetxController {
  final StockRepository _repository = Get.find<StockRepository>();
  final ChatRepository _chatRepository = Get.find<ChatRepository>();
  final ActivityRepository _activityRepository = Get.find<ActivityRepository>();

  final NotificationService _notificationService =
      Get.find<NotificationService>();

  //Stock state
  final RxList<StockModel> items = <StockModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt currentTab = 0.obs;
  final RxInt selectedFilter = 0.obs;

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final stockCount = 0.obs;

  final RxBool isEditMode = false.obs;
  String editingItemId = '';

  final RxList<LoanModel> loans = <LoanModel>[].obs;
  final borrowerNameController = TextEditingController();
  final Rxn<StockModel> selectedItem = Rxn<StockModel>();
  final Rxn<DateTime> loanDate = Rxn<DateTime>();
  final Rxn<DateTime> dueDate = Rxn<DateTime>();

  final Rxn<int> availableStockForDates = Rxn<int>();
  final RxBool isCheckingStock = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
    fetchLoans();

    ever(selectedItem, (_) => _tryCheckStock());
    ever(loanDate, (_) => _tryCheckStock());
    ever(dueDate, (_) => _tryCheckStock());
  }

  void _tryCheckStock() {
    if (selectedItem.value != null &&
        loanDate.value != null &&
        dueDate.value != null) {
      checkAvailableStock();
    } else {
      availableStockForDates.value = null;
    }
  }

  void showNotification() {
    _notificationService.showNotification(
      id: 1,
      title: "Notification",
      body: "This is a notification",
    );
  }

  Future<void> checkAvailableStock() async {
    if (selectedItem.value == null ||
        loanDate.value == null ||
        dueDate.value == null) {
      return;
    }

    final dateFormat = DateFormat('yyyy-MM-dd');
    isCheckingStock.value = true;
    try {
      final result = await _repository.getAvailableStock(
        itemId: selectedItem.value!.id,
        startDate: dateFormat.format(loanDate.value!),
        endDate: dateFormat.format(dueDate.value!),
      );
      availableStockForDates.value = result;
    } catch (e) {
      debugPrint('Error checking stock: $e');
      availableStockForDates.value = null;
    } finally {
      isCheckingStock.value = false;
    }
  }

  void setEditData(StockModel item) {
    isEditMode.value = true;
    editingItemId = item.id;
    nameController.text = item.name;
    categoryController.text = item.category;
    stockCount.value = item.totalStock;
  }

  Future<void> fetchItems() async {
    isLoading.value = true;
    try {
      final result = await _repository.getItems();
      items.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) {
    currentTab.value = index;
  }

  void changeFilter(int index) {
    selectedFilter.value = index;
  }

  void incrementStock() => stockCount.value++;
  void decrementStock() {
    if (stockCount.value > 0) stockCount.value--;
  }

  Future<void> submitForm() async {
    if (nameController.text.isEmpty ||
        categoryController.text.isEmpty ||
        stockCount.value == 0) {
      Get.snackbar('Error', 'Please fill all fields and set stock');
      return;
    }

    isLoading.value = true;
    try {
      if (isEditMode.value) {
        await _repository.updateItem(
          id: editingItemId,
          name: nameController.text.trim(),
          category: categoryController.text.trim(),
          stock: stockCount.value,
        );
        clearForm();
        fetchItems();
        Get.back(result: true);
        Get.snackbar('Success', 'Item updated successfully');
      } else {
        await _repository.addItem(
          name: nameController.text.trim(),
          category: categoryController.text.trim(),
          stock: stockCount.value,
        );

        _activityRepository.addLog(
          action: 'ADD_ITEM',
          details: {
            'item_name': nameController.text.trim(),
            'category': categoryController.text.trim(),
            'stock': stockCount.value,
          },
        );

        clearForm();
        fetchItems();
        Get.back();
        Get.snackbar('Success', 'Item added successfully');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteItem(String id) async {
    isLoading.value = true;
    try {
      await _repository.deleteItem(id);
      Get.back();
      Get.snackbar('Success', 'Item deleted successfully');
      fetchItems();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    isEditMode.value = false;
    editingItemId = '';
    nameController.clear();
    categoryController.clear();
    stockCount.value = 0;
  }

  //Loans
  Future<void> fetchLoans() async {
    try {
      final result = await _repository.getLoans();
      loans.assignAll(result);

      _notificationService.syncNotifications(loans, getItemName);
    } catch (e) {
      debugPrint('Error fetching loans: $e');
    }
  }

  Future<void> submitLoan() async {
    if (selectedItem.value == null ||
        borrowerNameController.text.isEmpty ||
        loanDate.value == null ||
        dueDate.value == null) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    if (availableStockForDates.value != null &&
        availableStockForDates.value! <= 0) {
      Get.snackbar('Error', 'Stok tidak tersedia untuk rentang tanggal ini');
      return;
    }

    final dateFormat = DateFormat('yyyy-MM-dd');

    isLoading.value = true;
    try {
      await _repository.borrowItem(
        itemId: selectedItem.value!.id,
        borrowerName: borrowerNameController.text.trim(),
        loanDate: dateFormat.format(loanDate.value!),
        dueDate: dateFormat.format(dueDate.value!),
      );

      _activityRepository.addLog(
        action: 'BORROW_ITEM',
        entityId: selectedItem.value!.id,
        details: {
          'item_name': selectedItem.value!.name,
          'borrower_name': borrowerNameController.text.trim(),
        },
      );

      await fetchLoans();

      final latestLoan = loans.firstWhereOrNull(
        (l) =>
            l.itemId == selectedItem.value!.id &&
            l.borrowerName == borrowerNameController.text.trim(),
      );
      if (latestLoan != null) {
        _notificationService.scheduleLoanNotifications(
          latestLoan,
          selectedItem.value!.name,
        );
      }

      clearLoanForm();
      fetchItems();
      Get.back();
      Get.snackbar('Success', 'Item borrowed successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      debugPrint('Error submitting loan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearLoanForm() {
    selectedItem.value = null;
    borrowerNameController.clear();
    loanDate.value = null;
    dueDate.value = null;
    availableStockForDates.value = null;
  }

  String getItemName(String itemId) {
    final item = items.firstWhereOrNull((e) => e.id == itemId);
    return item?.name ?? 'Unknown Item';
  }

  Future<void> returnItem(String loanId) async {
    isLoading.value = true;
    try {
      final loan = loans.firstWhereOrNull((l) => l.id == loanId);
      final itemName = loan != null ? getItemName(loan.itemId) : 'Unknown Item';

      await _repository.returnItem(loanId);

      _activityRepository.addLog(
        action: 'RETURN_ITEM',
        entityId: loanId,
        details: {
          'item_name': itemName,
          'borrower_name': loan?.borrowerName ?? 'Unknown',
        },
      );

      fetchLoans();
      fetchItems();

      // Cancel notifications
      _notificationService.cancelLoanNotifications(loanId);

      Get.back();
      Get.snackbar('Success', 'Item returned successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //chats
  Future<void> startChat(String itemId) async {
    try {
      final chatId = await _chatRepository.findOrCreateItemChat(itemId);
      Get.toNamed(Routes.CHAT_ROOM, arguments: chatId);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memulai chat: $e');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    categoryController.dispose();
    borrowerNameController.dispose();
    super.onClose();
  }
}
