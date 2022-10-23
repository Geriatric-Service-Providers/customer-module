import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final textname;
  final Function cardtap;
  CustomCard({this.textname, this.cardtap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      child: GestureDetector(
        onTap: ()=>Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => cardtap())),
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Text("$textname",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }
}
