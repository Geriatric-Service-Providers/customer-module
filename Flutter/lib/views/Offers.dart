import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopx/controllers/controllers.dart';
import 'package:shopx/models/Offer_factory.dart';
import 'package:shopx/views/globals.dart';
import 'package:shopx/views/homepage.dart';
import 'package:shopx/widgets/searchbar.dart';

class Offers extends StatelessWidget {
  final BannerController bannerController = Get.put(BannerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          SearchBar(),
          // SizedBox(
          //   height: 20,
          // ),
          Expanded(
            child: Obx(() {
              if (bannerController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return ListView.builder(
                    itemCount: bannerController.productList.length,
                    itemBuilder: (context, index) {
                      return Offercard(
                        banner: bannerController.productList[index],
                      );
                    });
            }),
          ),
        ],
      ),
    );
  }
}

class Offercard extends StatelessWidget {
  final Banners banner;

  Offercard({this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle
        // borderRadius: BorderRadius.circular(100.0),
          ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: () {
              Globals.primary = banner.productIds;
              Get.reset();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BannerProductPage(),
                  ));
            },
            child: Card(
              child: Image.network(
                banner.image,
                fit: BoxFit.fill,
              ),
              elevation: 3,
            ),
          )),
    );
  }
}

class OffercardHome extends StatelessWidget {
  final Banners banner;
  OffercardHome({this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.all(8),
      width: 300,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: () {
              Globals.primary = banner.productIds;
              Get.reset();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BannerProductPage(),
                  ));
            },
            child: Card(
              child: Image.network(
                banner.image,
                fit: BoxFit.fill,
                // fit: BoxFit.cover,
              ),
              elevation: 3,
            ),
          )),
    );
  }
}
