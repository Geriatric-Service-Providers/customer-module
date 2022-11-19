import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shopx/auth/secrets.dart';
import 'package:shopx/controllers/controllers.dart';
import 'package:shopx/widgets/bookButton.dart';
import 'package:shopx/widgets/serviceTile.dart';

// org view

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 136, 207, 226),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (dashboardController.isLoading.value)
                  return Center(child: CircularProgressIndicator());
                else
                  return StaggeredGridView.countBuilder(
                    padding: const EdgeInsets.all(10),
                    crossAxisCount: 1,
                    itemCount: dashboardController.serviceProviders.length,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 18,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: DashboardTile(
                              dashboardController.serviceProviders[index]),
                          onTap: () {
                            organizationId = dashboardController
                                .serviceProviders[index].id
                                .toString();

                            Get.to(OrganizationDetails());
                            Get.reset();
                          });
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  );
              }),
            )
          ],
        ),
      ),
    );
  }
}

// Member detail UI

class OrganizationDetails extends StatelessWidget {
  final MemberController memberController = Get.put(MemberController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (memberController.isLoading.value)
                  return Center(child: CircularProgressIndicator());
                else
                  return StaggeredGridView.countBuilder(
                    padding: const EdgeInsets.all(10),
                    crossAxisCount: 1,
                    itemCount: memberController.serviceProviders.length,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 18,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: MemberTile(
                              memberController.serviceProviders[index]),
                          onTap: () {
                            Get.reset();
                          });
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  );
              }),
            )
          ],
        ),
        bottomNavigationBar: BookButton(),
      ),
    );
  }
}
