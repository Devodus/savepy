class SearchMemberModel {
  String? message;
  List<SearchUserList>? userlist;
  String? flag;

  SearchMemberModel({this.message, this.userlist, this.flag});

  SearchMemberModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['userlist'] != null) {
      userlist = <SearchUserList>[];
      json['userlist'].forEach((v) {
        userlist!.add(new SearchUserList.fromJson(v));
      });
    }
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.userlist != null) {
      data['userlist'] = this.userlist!.map((v) => v.toJson()).toList();
    }
    data['flag'] = this.flag;
    return data;
  }
}

class SearchUserList {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  bool? assignGroupData;

  SearchUserList(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.assignGroupData});

  SearchUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    assignGroupData = json['assign_group_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['assign_group_data'] = this.assignGroupData;
    return data;
  }
}
