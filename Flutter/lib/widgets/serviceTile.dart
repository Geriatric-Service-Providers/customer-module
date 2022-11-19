import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/models/factory.dart';

class DashboardTile extends StatelessWidget {
  final Dashboard organization;
  const DashboardTile(this.organization);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025),
      height: MediaQuery.of(context).size.height * 0.16,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              "Organization Name : " + organization.name,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              "Phone : " + organization.phone,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              "Email : " + organization.email,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  final OrganizationDetails serviceProvider;
  const MemberTile(this.serviceProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025),
      height: MediaQuery.of(context).size.height * 0.16,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              "Name : " + serviceProvider.name,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              "Phone : " + serviceProvider.phone,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              "Qualification : " + serviceProvider.qualification,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
