import 'package:flutter/material.dart';
import 'package:shopx/models/cart_factory.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({Key key, this.product}) : super(key: key);
  final Items product;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 6,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                    product.product + "   ( UNIT : " + product.unit + ")"))),
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
                    product.price.toString() + " AED",
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
