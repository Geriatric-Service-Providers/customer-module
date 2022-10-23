import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:shopx/controllers/controllers.dart';
import 'package:shopx/main.dart';
import 'package:shopx/services/remote_services.dart';
import 'package:shopx/utils/styles.dart';
import 'package:shopx/views/ProductUi.dart';
import 'package:shopx/views/globals.dart';
import 'package:shopx/widgets/moideen_icons.dart';

class SearchBar extends StatefulWidget {
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final SearchController searchController = Get.put(SearchController());
  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      var result = barcodeScanRes;
      Globals.searchText = result;
      searchController.fetchSearchProducts();
      Get.reset();
      Get.to(SearchPage());
      Globals.searchText = "";
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // height: 50,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextField(
          // scrollPadding: EdgeInsets.only(top: 15, bottom: 15),
          // onTap: () {
          //   Globals.searchActive = "true";
          //   Get.to(SearchPage());
          // },
          //onTap: () => Get.to(() => null),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              // suffixIcon: IconButton(
              //   onPressed: () => scanBarcodeNormal(),
              //   icon: Icon(
              //     Icons.camera_alt,
              //     color: Colors.green.shade600,
              //     size: 25,
              //   ),
              // ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.black38),
              hintText: "Search",
              fillColor: Colors.white),
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchController searchController = Get.put(SearchController());
  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    print(barcodeScanRes);
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    RemoteServices.fetchCartProducts();
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                  controller: controller,
                  onChanged: (value) {
                    if (value.length != 0) {
                      Globals.searchText = value;
                      searchController.fetchSearchProducts();
                      Globals.searchText = "";
                    }
                  },
                  decoration: InputDecoration(
                      // suffixIcon: IconButton(
                      //   onPressed: () => scanQR(),
                      //   // icon: Icon(
                      //   //   Icons.camera_alt,
                      //   //   color: Colors.green.shade600,
                      //   // ),
                      // ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black38),
                      hintText: "Search",
                      fillColor: Colors.white)),
              Expanded(
                child: Obx(() {
                  if (searchController.isLoading.value)
                    return Center(child: CircularProgressIndicator());
                  else
                    return ListView.builder(
                      itemCount: searchController.productList.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: searchController.productList[index],
                        );
                      },
                    );
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SearchNav(),
      ),
    );
  }
}

class SearchNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      child: BottomAppBar(
        color: Colors.white,
        child: Row(children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => BottomNav());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  border: Border(
                                    top: BorderSide(
                                        width: 3.0, color: Styles.primaryColor),
                                  ),
                                  // color: Colors.amber
                                ),
                                margin: EdgeInsets.only(left: 15, right: 45),
                                padding: EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Moideen.moideen,
                                      color: Colors.red[900],
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "   ",
                                      style: Styles.placeHolder,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Globals.globalTabIndex = 1;
                                Get.to(() => BottomNav());
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      CupertinoIcons.person,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "profile",
                                      style: Styles.placeHolder,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () {
                                Globals.globalTabIndex = 2;
                                Get.to(() => BottomNav());
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.discount_outlined,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "Offers",
                                      style: Styles.placeHolder,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                              onTap: () {
                                Globals.globalTabIndex = 3;
                                Get.to(() => BottomNav());
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      CupertinoIcons.shopping_cart,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "Cart",
                                      style: Styles.placeHolder,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ]),
      ),
    );
  }
}
