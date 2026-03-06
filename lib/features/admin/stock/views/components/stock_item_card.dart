import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meminjam/configs/routes/route.dart';
import '../../models/stock_model.dart';
import 'package:meminjam/shared/styles/color_style.dart';
import 'package:meminjam/configs/themes/theme.dart';

class StockItemCard extends StatelessWidget {
  final StockModel item;

  const StockItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child!),
        );
      },
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.ITEM_DETAIL, arguments: item),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorStyle.neutral3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 110,
                decoration: BoxDecoration(
                  color: ColorStyle.neutral3,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.book, color: ColorStyle.neutral2, size: 40),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: AppTypography.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(item.category, style: AppTypography.subtitle),
                    const SizedBox(height: 12),
                    Text(
                      "${item.availableStock}/${item.totalStock} Stocks",
                      style: AppTypography.title.copyWith(
                        color: ColorStyle.primary,
                      ),
                    ),
                    if (item.availableStock < 5)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${item.availableStock} books left in stock!",
                          style: AppTypography.caption.copyWith(
                            color: ColorStyle.error,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
