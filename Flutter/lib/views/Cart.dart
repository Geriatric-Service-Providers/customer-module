import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopx/controllers/controllers.dart';
import 'package:shopx/models/cart_factory.dart';
import 'package:shopx/services/remote_services.dart';
import 'package:google_fonts/google_fonts.dart';

class CartCard extends StatefulWidget {
  final Items product;
  final bool isfav;
  CartCard({this.isfav = false, this.product});

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  final CartController cartController = Get.put(CartController());
  final Controller totalCounter = Get.put(Controller());
  dynamic count = 0;
  int incrementcounter(a, id, price, priceId) {
    if (count == 0 && a == -1) {
      setState(() {
        count = 0;
      });
    } else if (a == -1 && count == 1) {
      setState(() {
        count -= 1;
      });
      widget.product.quantity -= 1;
      totalCounter.decrement(price);
      RemoteServices.deleteCartProduct(id, priceId);
    } else if (count == 0 && a == 1) {
      setState(() {
        count += 1;
      });
      widget.product.quantity += 1;
      totalCounter.increment(price);
      RemoteServices.addToCart(id, 1, priceId);
    } else if (a == -1 && count + a > 0) {
      setState(() {
        count -= 1;
      });
      widget.product.quantity -= 1;
      totalCounter.decrement(price);
      RemoteServices.updateCartProduct(id, count, priceId);
    } else if (a == 1) {
      setState(() {
        count += 1;
      });
      widget.product.quantity += 1;
      totalCounter.increment(price);
      RemoteServices.updateCartProduct(id, count, priceId);
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    setState(() => {
          count = widget.product.quantity,
        });
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.025),
          // height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.product.product,
                    maxLines: 2,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                ),
              ]),
              Row(children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Price : " + widget.product.price.toString() + " AED",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                  ),
                ),
                ]),
              Row(
                children: [
                  Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Unit : " + widget.product.unit,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                  ),
                  ),
                  Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  margin: EdgeInsets.only(right: 10, left: 35, bottom: 5), 
                  child: TextButton(
                    onPressed: () => {null},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => {
                            incrementcounter(-1, widget.product.prodId,
                                widget.product.price, widget.product.priceId),
                          },
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: Colors.red.shade500,
                          ),
                        ),
                        Text(
                          "$count",
                          style: GoogleFonts.openSans(color: Colors.green),
                        ),
                        InkWell(
                          onTap: () => {
                            incrementcounter(1, widget.product.prodId,
                                widget.product.price, widget.product.priceId)
                          },
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.green.shade500,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 5,),
                      elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)),
                        primary: Colors.grey[200]),
                  ),
                )
                  )
              
                ],
              )
            ]),
          ),
        ),
      ],
    );
  }
}

class CartNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller total = Get.put(Controller());
    final CartController cart = Get.put(CartController());
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: BottomAppBar(
        color: Colors.white,
        child: Row(children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 12, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        cart.productList.length.toString() +
                                            " Items ",
                                        style: GoogleFonts.openSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        total.total.toString() + " AED",
                                        style: GoogleFonts.openSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.only(right: 10, bottom: 7),
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: ElevatedButton(
                              onPressed: () => {
                                if (cart.productList.length > 0)
                                  RemoteServices.placeOrder(),
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Place Order",
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.green[700],
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                          ),
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
