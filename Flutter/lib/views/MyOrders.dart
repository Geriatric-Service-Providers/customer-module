import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopx/views/PrevOrders.dart';
import 'package:shopx/widgets/searchbar.dart';
import 'package:shopx/controllers/controllers.dart';

class MyOrders extends StatefulWidget {
  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final PrevOrderController prevOrderController =
      Get.put(PrevOrderController());

  String dropDownValue = "Placed";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SearchBar(),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Spacer(),
                  DropdownButton(
                      value: dropDownValue,
                      icon: const Icon(Icons.arrow_downward),
                      items: [
                        'Placed',
                        'Confirmed',
                        'Shipped',
                        'Delivered',
                        'Cancelled'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          dropDownValue = newVal;
                        });
                      })
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                if (prevOrderController.isLoading.value)
                  return Center(child: CircularProgressIndicator());
                else
                  return ListView.builder(
                    itemCount: prevOrderController.orderList.length,
                    itemBuilder: (context, index) {
                      return PrevOrderCard(
                        orders: prevOrderController.orderList[index],
                        status: dropDownValue.toLowerCase(),
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
