class ProfileModel {
  UserProfileData? userProfileData;
  String? flag;

  ProfileModel({this.userProfileData, this.flag});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    userProfileData = json['user_profile_data'] != null
        ? new UserProfileData.fromJson(json['user_profile_data'])
        : null;
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userProfileData != null) {
      data['user_profile_data'] = this.userProfileData!.toJson();
    }
    data['flag'] = this.flag;
    return data;
  }
}

class UserProfileData {
  String? userId;
  Null? groupId;
  String? firstName;
  String? lastName;
  String? email;
  String? fldAddress;
  String? fldProfilePic;
  String? fldMobile;
  String? fldCountry;
  String? userType;

  UserProfileData(
      {this.userId,
        this.groupId,
        this.firstName,
        this.lastName,
        this.email,
        this.fldAddress,
        this.fldProfilePic,
        this.fldMobile,
        this.fldCountry,
        this.userType});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    groupId = json['group_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    fldAddress = json['fld_address'];
    fldProfilePic = json['fld_profile_pic'];
    fldMobile = json['fld_mobile'];
    fldCountry = json['fld_country'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['group_id'] = this.groupId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['fld_address'] = this.fldAddress;
    data['fld_profile_pic'] = this.fldProfilePic;
    data['fld_mobile'] = this.fldMobile;
    data['fld_country'] = this.fldCountry;
    data['user_type'] = this.userType;
    return data;
  }
}
