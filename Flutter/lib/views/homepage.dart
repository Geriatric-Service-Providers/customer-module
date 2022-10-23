import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/controllers/controllers.dart';
import 'package:shopx/services/remote_services.dart';
import 'package:shopx/views/Offers.dart';
import 'package:shopx/views/ProductUi.dart';
import 'package:shopx/views/Cart.dart';
import 'package:shopx/views/product_tile.dart';
import 'package:shopx/views/globals.dart';
import 'package:shopx/widgets/searchbar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  final CategoryController categoryController = Get.put(CategoryController());
  final BannerController bannerController = Get.put(BannerController());

  @override
  Widget build(BuildContext context) {
    RemoteServices.fetchCartProducts();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            SearchBar(),
            Container(
              height: 150,
              //child: Expanded(
              child: Obx(() {
                if (bannerController.isLoading.value)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bannerController.productList.length,
                    itemBuilder: (context, index) => OffercardHome(
                        banner: bannerController.productList[index]),
                  );
              }),
              //),
            ),
            Expanded(
              child: Obx(() {
                if (categoryController.isLoading.value)
                  return Center(child: CircularProgressIndicator());
                else
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: categoryController.productList.length,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 18,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: ProductTile(
                              categoryController.productList[index]),
                          onTap: () {
                            Globals.primary =
                                categoryController.productList[index].id;
                            Get.reset();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubCategories(),
                                ));
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

class Palliative extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //RemoteServices.fetchCartProducts();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            SearchBar(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class SubCategories extends StatelessWidget {
  final SubCategoryController subCategoryController =
      Get.put(SubCategoryController());
  @override
  Widget build(BuildContext context) {
    //RemoteServices.fetchCartProducts();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            SearchBar(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(
                () {
                  if (subCategoryController.isLoading.value)
                    return Center(child: CircularProgressIndicator());
                  else
                    return StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: subCategoryController.productList.length,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 18,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: ProductTile(
                                subCategoryController.productList[index]),
                            onTap: () {
                              Globals.primary =
                                  subCategoryController.productList[index].id;
                              Get.reset();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductPage(),
                                  ));
                            });
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    //RemoteServices.fetchCartProducts();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SearchBar(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value)
                  return Center(child: CircularProgressIndicator());
                else
                  return ListView.builder(
                    itemCount: productController.productList.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: productController.productList[index],
                      );
                    },
                  );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class BannerProductPage extends StatelessWidget {
  final BannerProductController productController =
      Get.put(BannerProductController());
  @override
  Widget build(BuildContext context) {
    //RemoteServices.fetchCartProducts();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SearchBar(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value)
                  return Center(child: CircularProgressIndicator());
                else
                  return ListView.builder(
                    itemCount: productController.productList.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: productController.productList[index],
                      );
                    },
                  );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    cartController.fetchCartProducts();
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Your Cart",
                  style: GoogleFonts.openSans(
                      fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ))
            ],
          ),
          Expanded(
            child: Obx(() {
              if (cartController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return Obx(
                  () => ListView.builder(
                    itemCount: cartController.productList.length,
                    itemBuilder: (context, index) {
                      return CartCard(
                        product: cartController.productList[index],
                      );
                    },
                  ),
                );
            }),
          )
        ],
      ),
      bottomNavigationBar: CartNav(),
    ));
  }
}
