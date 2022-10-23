import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/controllers/controllers.dart';
import 'package:shopx/models/cart_factory.dart';
import 'package:shopx/models/product_factory.dart';
import 'package:shopx/services/remote_services.dart';
import 'package:shopx/utils/styles.dart';
import 'package:shopx/widgets/AddbuttonUnit.dart';

class ProductCard extends StatefulWidget {
  final Category product;
  final bool isfav;
  ProductCard({this.isfav = false, this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final ProductController productController = Get.put(ProductController());
  final Controller totalCounter = Get.put(Controller());

  dynamic pcsCount = 1;
  dynamic outCount = 1;
  dynamic ctnCount = 1;

  int incrementPcsCounter(a, id, price, priceId) {
    if (pcsCount == 1 && a == -1) {
      setState(() {
        pcsCount = 1;
      });
    } else if (a == -1 && pcsCount == 2) {
      setState(() {
        pcsCount -= 1;
      });
    } else if (pcsCount == 1 && a == 1) {
      setState(() {
        pcsCount += 1;
      });
    } else if (a == -1 && pcsCount + a > 0) {
      setState(() {
        pcsCount -= 1;
      });
    } else if (a == 1) {
      setState(() {
        pcsCount += 1;
      });
    }
    return 0;
  }

  int incrementOutCounter(a, id, price, priceId) {
    if (outCount == 1 && a == -1) {
      setState(() {
        outCount = 1;
      });
    } else if (a == -1 && outCount == 2) {
      setState(() {
        outCount -= 1;
      });
    } else if (outCount == 1 && a == 1) {
      setState(() {
        outCount += 1;
      });
    } else if (a == -1 && outCount + a > 0) {
      setState(() {
        outCount -= 1;
      });
    } else if (a == 1) {
      setState(() {
        outCount += 1;
      });
    }
    return 0;
  }

  int incrementCtnCounter(a, id, price, priceId) {
    if (ctnCount == 1 && a == -1) {
      setState(() {
        ctnCount = 1;
      });
    } else if (a == -1 && ctnCount == 2) {
      setState(() {
        ctnCount -= 1;
      });
    } else if (ctnCount == 1 && a == 1) {
      setState(() {
        ctnCount += 1;
      });
    } else if (a == -1 && ctnCount + a > 0) {
      setState(() {
        ctnCount -= 1;
      });
    } else if (a == 1) {
      setState(() {
        ctnCount += 1;
      });
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    bool ctnAvail = false;
    bool pcsAvail = false;
    bool outAvail = false;
    String ctnPrice = "-";
    String pcsPrice = "-";
    String outPrice = "-";
    String ctnId;
    String pcsId;
    String outId;

    for (int i = 0; i < widget.product.prices.length; i++) {
      if (widget.product.prices[i].unit == "CTN") {
        ctnAvail = true;
        ctnPrice = widget.product.prices[i].price.toString();
        ctnId = widget.product.prices[i].id.toString();
      }
      if (widget.product.prices[i].unit == "PCS") {
        pcsAvail = true;
        pcsPrice = widget.product.prices[i].price.toString();
        pcsId = widget.product.prices[i].id.toString();
      }
      if (widget.product.prices[i].unit == "OUT") {
        outAvail = true;
        outPrice = widget.product.prices[i].price.toString();
        outId = widget.product.prices[i].id.toString();
      }
    }
    return Container(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsetsDirectional.only(top: 20, start: 20),
              child: Text(
                widget.product.title,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.normal, fontSize: 14),
              ),
            ),
            Row(
              children: [
                // PCS Qty
                Expanded(
                  child: Container(
                  padding: const EdgeInsets.all(0.0),   
                  margin: EdgeInsets.symmetric(horizontal: 10),               
                  child: TextButton(
                    onPressed: () => {null},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => {
                            if(pcsAvail) {
                              incrementPcsCounter(-1, widget.product.id,
                                ctnPrice, ctnId),
                            }                            
                          },
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: 
                              pcsAvail
                              ? Colors.red.shade500
                              : Colors.white
                          ),
                        ),
                        Text(
                          "$pcsCount",
                          style: GoogleFonts.openSans(
                            color: 
                              pcsAvail
                              ? Colors.green
                              : Colors.white
                            ),
                        ),
                        InkWell(
                          onTap: () => {
                            if(pcsAvail) {
                              incrementPcsCounter(1, widget.product.id,
                                ctnPrice, ctnId)
                            }                            
                          },
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: 
                              pcsAvail
                              ? Colors.green.shade500
                              : Colors.white
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 5,),
                      elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(09)),
                        primary: Colors.grey[200]),
                  ),
                ),
                ),
                // OUT Qty
                Expanded(
                  child: Container(
                  padding: const EdgeInsets.all(0.0),   
                  margin: EdgeInsets.symmetric(horizontal: 10),               
                  child: TextButton(
                    onPressed: () => {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => {
                            if(outAvail) {
                              incrementOutCounter(-1, widget.product.id,
                                ctnPrice, ctnId),
                            }                            
                          },
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: 
                              outAvail
                              ? Colors.red.shade500
                              : Colors.white,
                          ),
                        ),
                        Text(
                          "$outCount",
                          style: GoogleFonts.openSans(
                            color: 
                              outAvail
                            ? Colors.green
                              : Colors.white
                            ),
                        ),
                        InkWell(
                          onTap: () => {
                            if(outAvail) {
                              incrementOutCounter(1, widget.product.id,
                                ctnPrice, ctnId)
                            }                            
                          },
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: 
                              outAvail
                              ? Colors.green.shade500
                              : Colors.white
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 5,),
                      elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(09)),
                        primary: Colors.grey[200]),
                  ),
                ),
                ),
                // CTN Qty
                Expanded(
                  child: Container(
                  padding: const EdgeInsets.all(0.0),   
                  margin: EdgeInsets.symmetric(horizontal: 10),               
                  child: TextButton(
                    onPressed: () => {null},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => {
                            if(ctnAvail) {
                              incrementCtnCounter(-1, widget.product.id,
                                ctnPrice, ctnId),
                            }                            
                          },
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: 
                              ctnAvail
                              ? Colors.red.shade500
                              : Colors.white
                          ),
                        ),
                        Text(
                          "$ctnCount",
                          style: GoogleFonts.openSans(
                            color: 
                              ctnAvail
                              ? Colors.green
                              : Colors.white
                            ),
                        ),
                        InkWell(
                          onTap: () => {
                            if(ctnAvail) {
                              incrementCtnCounter(1, widget.product.id,
                                ctnPrice, ctnId)
                            }                            
                          },
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: 
                              ctnAvail
                              ? Colors.green.shade500
                              : Colors.white
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 5,),
                      elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(09)),
                        primary: Colors.grey[200]),
                  ),
                ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, top: 8),
                    child: PriceButton(
                      price: pcsPrice,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, top: 8),
                    child: PriceButton(
                      price: outPrice,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, top: 8),
                    child: PriceButton(
                      price: ctnPrice,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, top: 8, bottom: 15),
                    child: AddButtonUnit(
                      id: widget.product.id,
                      qty: pcsCount,
                      text: "PCS",
                      avail: pcsAvail,
                      priceId: pcsId,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, top: 8, bottom: 15),
                    child: AddButtonUnit(
                      id: widget.product.id,
                      qty: outCount,
                      text: "OUT",
                      avail: outAvail,
                      priceId: outId,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, top: 8, bottom: 15),
                    child: AddButtonUnit(                      
                      id: widget.product.id,
                      qty: ctnCount,
                      text: "CTN",
                      avail: ctnAvail,
                      priceId: ctnId,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
