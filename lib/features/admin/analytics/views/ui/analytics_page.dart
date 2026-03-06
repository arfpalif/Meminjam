import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/shared/widgets/state_widgets.dart';
import 'package:intl/intl.dart';
import '../../controllers/analytics_controller.dart';

class AnalyticsPage extends GetView<AnalyticsController> {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.neutral4,
      appBar: AppBar(
        title: Text(
          'Analytics Dashboard',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorStyle.neutral1),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: LoadingWidget());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: ErrorStateWidget(
              message: controller.errorMessage.value,
              onRetry: controller.fetchData,
            ),
          );
        }

        final data = controller.analyticsData.value;
        if (data == null) return const SizedBox();

        return RefreshIndicator(
          onRefresh: controller.fetchData,
          color: ColorStyle.primary,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuickStats(data.quickStats),
                const SizedBox(height: 24),
                _buildSectionHeader('Category Distribution'),
                const SizedBox(height: 12),
                _buildCategoryPieChart(data.categoryData),
                const SizedBox(height: 32),
                _buildSectionHeader('Top Borrowed Items'),
                const SizedBox(height: 12),
                _buildTopBorrowedItems(data.topBorrowedItems),
                const SizedBox(height: 32),
                _buildSectionHeader('Overdue Trend'),
                const SizedBox(height: 12),
                _buildOverdueTrendChart(data.overdueTrend),
                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTypography.title.copyWith(
        fontSize: 18,
        color: ColorStyle.neutral1,
      ),
    );
  }

  Widget _buildQuickStats(dynamic stats) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          'Total Assets',
          stats.totalAssets.toString(),
          Icons.inventory_2,
          Colors.blue,
        ),
        _buildStatCard(
          'Active Loans',
          stats.activeLoans.toString(),
          Icons.handshake,
          Colors.orange,
        ),
        _buildStatCard(
          'Utilization',
          '${stats.utilizationRate.toStringAsFixed(1)}%',
          Icons.show_chart,
          Colors.purple,
        ),
        _buildStatCard(
          'Overdue',
          stats.overdueCount.toString(),
          Icons.warning_amber_rounded,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: AppTypography.title.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: ColorStyle.neutral2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPieChart(List<dynamic> categoryData) {
    if (categoryData.isEmpty)
      return const EmptyStateWidget(
        title: "No data",
        message: "No category data available.",
      );

    final colors = [
      ColorStyle.primary,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
    ];

    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: PieChart(
        PieChartData(
          sectionsSpace: 4,
          centerSpaceRadius: 40,
          sections: List.generate(categoryData.length, (i) {
            final data = categoryData[i];
            return PieChartSectionData(
              color: colors[i % colors.length],
              value: data.count.toDouble(),
              title: data.category,
              radius: 50,
              titleStyle: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTopBorrowedItems(List<dynamic> items) {
    if (items.isEmpty)
      return const EmptyStateWidget(
        title: "No data",
        message: "No loan history found.",
      );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    item.itemName,
                    style: AppTypography.subtitle.copyWith(
                      color: ColorStyle.neutral1,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: LinearProgressIndicator(
                      value:
                          item.borrowCount /
                          (items.first.borrowCount > 0
                              ? items.first.borrowCount
                              : 1),
                      backgroundColor: ColorStyle.neutral3,
                      valueColor: const AlwaysStoppedAnimation(
                        ColorStyle.primary,
                      ),
                      minHeight: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${item.borrowCount}',
                  style: AppTypography.title.copyWith(fontSize: 14),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOverdueTrendChart(List<dynamic> trend) {
    if (trend.isEmpty)
      return const EmptyStateWidget(
        title: "All Clear",
        message: "No overdue items recorded lately.",
      );

    return Container(
      height: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY:
              (trend
                  .map((e) => e.count)
                  .reduce((a, b) => a > b ? a : b)
                  .toDouble() +
              1),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() < 0 || value.toInt() >= trend.length)
                    return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      DateFormat('MM/dd').format(trend[value.toInt()].date),
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: ColorStyle.neutral2,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(trend.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: trend[i].count.toDouble(),
                  color: ColorStyle.error,
                  width: 12,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
