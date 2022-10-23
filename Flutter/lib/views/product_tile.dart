import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/models/product_factory.dart';

class ProductTile extends StatelessWidget {
  final Category product;
  const ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    dynamic image;
    if (product.image == null) {
      image = AssetImage("images/profile_bg.png");
    } else {
      image = NetworkImage(product.image);
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
        image: DecorationImage(image: image, fit: BoxFit.fill),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025),
      height: MediaQuery.of(context).size.height * 0.16,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            right: 0,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              color: Colors.green.shade700.withOpacity(0.7),
              child: Padding(
                padding: const EdgeInsets.only(left: 28, right: 5),
                child: Center(
                  child: Text(
                    // product.title.toUpperCase(),
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
