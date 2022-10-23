import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/controllers/controllers.dart';
import 'package:shopx/models/orders_factory.dart';
import 'package:shopx/views/PrevOrderSummary.dart';

// ignore: must_be_immutable
class PrevOrderCard extends StatelessWidget {
  final Orders orders;
  dynamic status;
  PrevOrderCard({this.orders, this.status});
  final PrevOrderController prevOrderController =
      Get.put(PrevOrderController());
  @override
  Widget build(BuildContext context) {
    if (status == "delivered") status = "paid";
    if (status == "shipped") status = "dispatched";
    dynamic buttText;
    if (orders.status == "paid")
      buttText = Text(
        "Status : DELIVERED",
        style:
            GoogleFonts.openSans(fontWeight: FontWeight.normal, fontSize: 14),
      );
    else if (orders.status == "dispatched")
      buttText = Text(
        "Status : SHIPPED",
        style:
            GoogleFonts.openSans(fontWeight: FontWeight.normal, fontSize: 14),
      );
    else
      buttText = Text(
        "Status : " + orders.status.toUpperCase(),
        style:
            GoogleFonts.openSans(fontWeight: FontWeight.normal, fontSize: 14),
      );
    if (status == orders.status)
      return GestureDetector(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviousOrder(
                  products: prevProdFromJson(jsonEncode(orders.products)),
                  id: orders.id,
                  date: orders.date,
                  prodlen: orders.products.length,
                  total: orders.total,
                  name: orders.name,
                ),
                //orderid, orderdate, products.length, ordertotal, ordername
              ))
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.025),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding:
                          const EdgeInsetsDirectional.only(top: 20, start: 25),
                      child: Text(
                        "Order ID : " + orders.id.toString(),
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding:
                          const EdgeInsetsDirectional.only(top: 20, end: 30),
                      child: Text(
                        "Total : " + orders.total.toString() + " AED",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  indent: 25,
                  endIndent: 25,
                  thickness: 1.0,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: const EdgeInsetsDirectional.only(
                            top: 20, start: 25),
                        child: buttText),
                    Spacer(),
                    Container(
                      padding:
                          const EdgeInsetsDirectional.only(top: 20, end: 30),
                      child: Text("Date : " + orders.date),
                    )
                  ],
                ),
                // Container(),
              ],
            ),
          ),
        ),
      );
    else
      return Container(
        width: 0,
        height: 0,
      );
  }
}
