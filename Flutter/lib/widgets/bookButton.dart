import 'package:flutter/material.dart';
import 'package:shopx/services/remote_services.dart';

class BookButton extends StatefulWidget {
  @override
  State<BookButton> createState() => _BookButtonState();
}

class _BookButtonState extends State<BookButton> {
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    // dateController.text = "";
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: BottomAppBar(
        child: Row(children: [
          Expanded(
            child: Container(
                // margin: EdgeInsets.only(left: 12, top: 10),
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                        child: ElevatedButton(
                            onPressed: () async {
                              DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      DateTime.now(), //get today's date
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));
                              selectedDate = pickedDate.toUtc();
                              RemoteServices.bookAppointments(
                                  DateUtils.dateOnly(selectedDate).toString());
                            },
                            child: Container(
                                child:
                                    Center(child: Text("Book Appointment"))))))
              ],
            )),
          ),
        ]),
      ),
    );
  }
}
