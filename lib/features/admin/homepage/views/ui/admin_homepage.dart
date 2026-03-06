import 'package:flutter/material.dart';
import '../components/home_header.dart';
import '../components/home_banner.dart';
import '../components/home_quick_action.dart';
import '../components/home_top_stats.dart';
import '../components/home_recent_activity.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 12),
                HomeBanner(),
                SizedBox(height: 24),
                HomeQuickAction(),
                SizedBox(height: 24),
                HomeTopStats(),
                SizedBox(height: 24),
                HomeRecentActivity(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
