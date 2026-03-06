class AnalyticsModel {
  final QuickStats quickStats;
  final List<CategoryData> categoryData;
  final List<TopItemData> topBorrowedItems;
  final List<OverdueData> overdueTrend;

  AnalyticsModel({
    required this.quickStats,
    required this.categoryData,
    required this.topBorrowedItems,
    required this.overdueTrend,
  });
}

class QuickStats {
  final int totalAssets;
  final int activeLoans;
  final double utilizationRate;
  final int overdueCount;

  QuickStats({
    required this.totalAssets,
    required this.activeLoans,
    required this.utilizationRate,
    required this.overdueCount,
  });
}

class CategoryData {
  final String category;
  final int count;

  CategoryData({required this.category, required this.count});
}

class TopItemData {
  final String itemName;
  final int borrowCount;

  TopItemData({required this.itemName, required this.borrowCount});
}

class OverdueData {
  final DateTime date;
  final int count;

  OverdueData({required this.date, required this.count});
}
