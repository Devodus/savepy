class PlanListModel {
  List<Planlist>? planlist;
  String? flag;

  PlanListModel({this.planlist, this.flag});

  PlanListModel.fromJson(Map<String, dynamic> json) {
    if (json['planlist'] != null) {
      planlist = <Planlist>[];
      json['planlist'].forEach((v) {
        planlist!.add(new Planlist.fromJson(v));
      });
    }
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.planlist != null) {
      data['planlist'] = this.planlist!.map((v) => v.toJson()).toList();
    }
    data['flag'] = this.flag;
    return data;
  }
}

class Planlist {
  String? uid;
  String? fldGroupId;
  String? fldPlanName;
  String? fldAmount;
  String? fldDuration;

  Planlist(
      {this.uid,
        this.fldGroupId,
        this.fldPlanName,
        this.fldAmount,
        this.fldDuration});

  Planlist.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    fldGroupId = json['fld_group_id'];
    fldPlanName = json['fld_plan_name'];
    fldAmount = json['fld_amount'];
    fldDuration = json['fld_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['fld_group_id'] = this.fldGroupId;
    data['fld_plan_name'] = this.fldPlanName;
    data['fld_amount'] = this.fldAmount;
    data['fld_duration'] = this.fldDuration;
    return data;
  }
}
