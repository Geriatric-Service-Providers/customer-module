import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/views/globals.dart';
import 'package:shopx/views/summarycard.dart';
import 'package:shopx/widgets/searchbar.dart';
import 'package:shopx/controllers/controllers.dart';
import 'package:get/get.dart';

class OrderSummary extends StatelessWidget {
  final Controller total = Get.put(Controller());
  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 30, top: 10, bottom: 20),
                  child: Text(
                    "Summary",
                    style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              height: 365,
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsetsDirectional.only(
                                top: 20, start: 15),
                            child: Text(
                              "Order ID : " + Globals.orderId,
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: const EdgeInsetsDirectional.only(
                                top: 20, end: 15),
                            child: Text(
                              "Date : " + Globals.orderDate,
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 1.0,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemCount: cartController.productList.length,
                          itemBuilder: (context, index) {
                            return SummaryCard(
                                product: cartController.productList[index]);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              indent: 20,
                              endIndent: 20,
                              thickness: 1.0,
                              color: Colors.grey,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, start: 25),
                child: Text(
                  "Price (" +
                      cartController.productList.length.toString() +
                      " Items)",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, end: 30),
                child: Text(
                  // Globals.cartotal.toString() + " AED",
                  total.total.toString() + " AED",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, start: 25),
                child: Text(
                  "Discount",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, end: 30),
                child: Text(
                  "NA",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, start: 25),
                child: Text(
                  "Delivery Charges",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, end: 30),
                child: Text(
                  "Free",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, start: 25),
                child: Text(
                  "Total Amount",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, end: 30),
                child: Text(
                  // Globals.cartotal.toString() + " AED",
                  total.total.toString() + " AED",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            thickness: 1.0,
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, start: 25),
                child: Text(
                  "Deliver To",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, end: 30),
                child: Text(
                  Globals.name.toUpperCase(),
                  style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
          SizedBox(height: 35,)
        ],
      ),
    );
  }
}
