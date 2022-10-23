import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:shopx/views/globals.dart";
import 'package:get/get.dart';
import 'package:shopx/controllers/controllers.dart';
import 'package:shopx/services/remote_services.dart';

class AddButtonUnit extends StatefulWidget {
  AddButtonUnit({Key key, this.id, this.qty, this.priceId, this.text, this.avail})
      : super(key: key);
  final int id;
  final int qty;
  final bool avail;
  final String text;
  final dynamic priceId;

  @override
  _AddButtonUnitState createState() =>
      _AddButtonUnitState(id, qty, priceId, text, avail);
}

class _AddButtonUnitState extends State<AddButtonUnit> {
  final int id;
  final int qty;
  final String text;
  final dynamic priceId;
  final bool avail;

  bool initAdded = false;
  bool tapped = false;
  dynamic buttcolor = Colors.green.shade500;
  _AddButtonUnitState(this.id, this.qty, this.priceId, this.text, this.avail);
  final productController = Get.put(ProductController());
  dynamic buttText;
  dynamic iconcolor;

  @override
  void initState() {
    super.initState();
    print(qty);

  }

  void stater() {
    // if (Globals.cart.contains(id.toString())) {
  if (Globals.cart.contains('"price_id":$priceId')) {
    print('"2 price_id":$priceId');
      setState(() {
        buttText = Text(
          "- " + text,
          style: GoogleFonts.openSans(color: Colors.white),
        );
        tapped = true;
        buttcolor = Colors.red.shade400;
      });
    } else {

      setState(() {
        buttText = Text(
          "+ " + text,
          style: GoogleFonts.openSans(color: Colors.white),
        );
        tapped = false;
        buttcolor = Colors.green.shade500;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (initAdded == false) stater();
    void handler(tapped) {
      if (tapped) {
        print(widget.qty);
        
        RemoteServices.addToCart(id, widget.qty, priceId);

        buttText = Text(
          "- " + text,
          style: GoogleFonts.openSans(color: Colors.white),
        );
        buttcolor = Colors.red.shade400;
        tapped = !tapped;
        setState(() {});

      } else {
        RemoteServices.deleteCartProduct(id, priceId);
        buttText = Text(
          "+ " + text,
          style: GoogleFonts.openSans(color: Colors.white),
        );
        buttcolor = Colors.green.shade500;
        tapped = !tapped;
        setState(() {});
      }
    }

    dynamic childButt = ElevatedButton(
      onPressed: null,
      child: buttText,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          primary: Colors.grey.shade700),
    );

    if (avail) {
      childButt = ElevatedButton(
        onPressed: () => {handler(tapped = !tapped), initAdded = true},
        child: buttText,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            primary: buttcolor),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.008,
      height: MediaQuery.of(context).size.height * 0.04,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: childButt,
      ),
    );
  }
}

class PriceButton extends StatelessWidget {
  PriceButton({Key key, this.price}) : super(key: key);
  final dynamic price;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.008,
      //height: MediaQuery.of(context).size.height * 0.04,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextButton(
          onPressed: null,
          child: Text(
            price,
            style: GoogleFonts.openSans(color: Colors.black),
          ),
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black,
                      width: 0.8,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5)),
              primary: Colors.white),
        ),
      ),
    );
  }
}
