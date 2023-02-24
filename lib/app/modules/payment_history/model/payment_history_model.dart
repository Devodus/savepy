class UserPaymentHistoryModel {
  List<UserPaymentHistory>? userPaymentHistory;
  String? flag;

  UserPaymentHistoryModel({this.userPaymentHistory, this.flag});

  UserPaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['user_payment_history'] != null) {
      userPaymentHistory = <UserPaymentHistory>[];
      json['user_payment_history'].forEach((v) {
        userPaymentHistory!.add(new UserPaymentHistory.fromJson(v));
      });
    }
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userPaymentHistory != null) {
      data['user_payment_history'] =
          this.userPaymentHistory!.map((v) => v.toJson()).toList();
    }
    data['flag'] = this.flag;
    return data;
  }
}

class UserPaymentHistory {
  String? userId;
  String? fldGroupId;
  String? groupName;
  String? fldTransactionId;
  String? fldAmount;
  String? fldPaymentDate;

  UserPaymentHistory(
      {this.userId,
        this.fldGroupId,
        this.groupName,
        this.fldTransactionId,
        this.fldAmount,
        this.fldPaymentDate});

  UserPaymentHistory.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fldGroupId = json['fld_group_id'];
    groupName = json['group_name'];
    fldTransactionId = json['fld_transaction_id'];
    fldAmount = json['fld_amount'];
    fldPaymentDate = json['fld_payment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['fld_group_id'] = this.fldGroupId;
    data['group_name'] = this.groupName;
    data['fld_transaction_id'] = this.fldTransactionId;
    data['fld_amount'] = this.fldAmount;
    data['fld_payment_date'] = this.fldPaymentDate;
    return data;
  }
}
