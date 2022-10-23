import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/models/orders_factory.dart';
import 'package:shopx/widgets/searchbar.dart';

class PreviousOrder extends StatelessWidget {
  PreviousOrder(
      {Key key,
      this.products,
      this.id,
      this.date,
      this.prodlen,
      this.total,
      this.name})
      : super(key: key);
  final List<Products> products;
  final id;
  final date;
  final prodlen;
  final name;
  final total;

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
              //width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
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
                              "Order ID : " + id.toString(),
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: const EdgeInsetsDirectional.only(
                                top: 20, end: 15),
                            child: Text(
                              "Date : " + date.toString(),
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
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return SummaryCard(product: products[index]);
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
                  "Price (" + prodlen.toString() + " Items)",
                  style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsetsDirectional.only(top: 20, end: 30),
                child: Text(
                  total.toString() + " AED",
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
                  total.toString() + " AED",
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
                  name.toUpperCase(),
                  style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
          Container(
            height: 50,
          )
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({Key key, this.product}) : super(key: key);
  final Products product;
  @override
  Widget build(BuildContext context) {
    dynamic price = product.price;
    return Row(
      children: [
        Expanded(
            flex: 6,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(product.title))),
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Text(
                    product.quantity.toString(),
                    style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                  ),
                  VerticalDivider(
                    width: 20,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Text(
                    price.toString() + " AED",
                    style: GoogleFonts.openSans(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
