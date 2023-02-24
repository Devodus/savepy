class GroupListModel {
  List<Grouplistusr>? grouplistusr;
  String? flag;

  GroupListModel({this.grouplistusr, this.flag});

  GroupListModel.fromJson(Map<String, dynamic> json) {
    if (json['grouplistusr'] != null) {
      grouplistusr = <Grouplistusr>[];
      json['grouplistusr'].forEach((v) {
        grouplistusr!.add(new Grouplistusr.fromJson(v));
      });
    }
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.grouplistusr != null) {
      data['grouplistusr'] = this.grouplistusr!.map((v) => v.toJson()).toList();
    }
    data['flag'] = this.flag;
    return data;
  }
}

class Grouplistusr {
  String? fldGroupName;
  String? fldGroupId;

  Grouplistusr({this.fldGroupName, this.fldGroupId});

  Grouplistusr.fromJson(Map<String, dynamic> json) {
    fldGroupName = json['fld_group_name'];
    fldGroupId = json['fld_group_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fld_group_name'] = this.fldGroupName;
    data['fld_group_id'] = this.fldGroupId;
    return data;
  }
}
