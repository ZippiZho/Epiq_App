import 'package:epiq_fasha/app/modules/bookmark/views/bookmark_view.dart';
import 'package:epiq_fasha/app/modules/historypeminjaman/views/historypeminjaman_view.dart';
import 'package:epiq_fasha/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../components/customBarMaterial.dart';
import '../../home/views/home_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Stack(
                  children: [
                    // Konten halaman
                    IndexedStack(
                      index: controller.tabIndex,
                      children: const [
                        HomeView(),
                        BookmarkView( ),
                        HistorypeminjamanView(),
                        ProfileView(),
                      ],
                    ),
                    // Bottom Bar
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: CustomBottomBarMaterial(
                        onTap: controller.changeTabIndex,
                        currentIndex: controller.tabIndex,
                      ),
                    ),
                  ],
                ),
              ),
          );
        }
    );
  }
}
