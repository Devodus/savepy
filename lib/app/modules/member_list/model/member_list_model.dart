class MemberListModel {
  String? message;
  LeaderData? leaderData;
  List<Userlist>? userlist;
  String? flag;

  MemberListModel({this.message, this.leaderData, this.userlist, this.flag});

  MemberListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    leaderData = json['leader_data'] != null
        ? new LeaderData.fromJson(json['leader_data'])
        : null;
    if (json['userlist'] != null) {
      userlist = <Userlist>[];
      json['userlist'].forEach((v) {
        userlist!.add(new Userlist.fromJson(v));
      });
    }
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.leaderData != null) {
      data['leader_data'] = this.leaderData!.toJson();
    }
    if (this.userlist != null) {
      data['userlist'] = this.userlist!.map((v) => v.toJson()).toList();
    }
    data['flag'] = this.flag;
    return data;
  }
}

class LeaderData {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? fldAddress;
  String? fldMobile;
  String? userType;

  LeaderData(
      {this.userId,
        this.firstName,
        this.lastName,
        this.email,
        this.fldAddress,
        this.fldMobile,
        this.userType});

  LeaderData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    fldAddress = json['fld_address'];
    fldMobile = json['fld_mobile'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['fld_address'] = this.fldAddress;
    data['fld_mobile'] = this.fldMobile;
    data['user_type'] = this.userType;
    return data;
  }
}

class Userlist {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? userPaymentEligibility;
  bool? belongToGroup;

  Userlist(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.userPaymentEligibility,
        this.belongToGroup});

  Userlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    userPaymentEligibility = json['user_payment_eligibility'];
    belongToGroup = json['belong_to_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['user_payment_eligibility'] = this.userPaymentEligibility;
    data['belong_to_group'] = this.belongToGroup;
    return data;
  }
}
