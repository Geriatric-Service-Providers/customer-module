import 'dart:convert';

List<Dashboard> DashboardfromJson(String str) =>
    List<Dashboard>.from(json.decode(str).map((x) => Dashboard.fromJson(x)));

List<OrganizationDetails> MemberDetailsfromJson(String str) =>
    List<OrganizationDetails>.from(json.decode(str).map((x) => OrganizationDetails.fromJson(x)));

class Dashboard {
  int id;
  String name;
  String email;
  String phone;
  String services;
  String address;
  String city;

  Dashboard(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.services,
      this.address,
      this.city});

  Dashboard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    services = json['services'];
    address = json['address'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['services'] = this.services;
    data['address'] = this.address;
    data['city'] = this.city;
    return data;
  }
}


class OrganizationDetails {
  String name;
  String email;
  String qualification;
  String skills;
  String availTime;
  String phone;
  String address;

  OrganizationDetails(
      {this.name,
      this.email,
      this.qualification,
      this.skills,
      this.availTime,
      this.phone,
      this.address});

  OrganizationDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    qualification = json['qualification'];
    skills = json['skills'];
    availTime = json['availTime'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['qualification'] = this.qualification;
    data['skills'] = this.skills;
    data['availTime'] = this.availTime;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

class Login {
  String access;
  Login(this.access);
  factory Login.fromJson(dynamic json) {
    return Login(json['access'] as String);
  }
}
