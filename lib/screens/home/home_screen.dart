import 'package:bbibic_store/screens/home/widgets/goods_most_popular_list_widget.dart';
import 'package:bbibic_store/screens/home/widgets/goods_most_recent_list_widget.dart';
import 'package:bbibic_store/screens/home/widgets/home_app_bar.dart';
import 'package:bbibic_store/screens/home/widgets/home_banner_widget.dart';
import 'package:bbibic_store/screens/home/widgets/home_menu_widget.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../widgets/company_info_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey150,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeAppBar(),
              const HomeBannerWidget(),
              HomeMenuWidget(),
              const SizedBox(height: 12),
              const GoodsMostRecentListWidget(),
              const SizedBox(height: 12),
              const GoodsMostPopularListWidget(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: AppColors.grey300),
                ),
              ),
              const CompanyInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
