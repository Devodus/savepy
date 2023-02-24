class GroupPaymentModel {
  List<GroupPaymentHistory>? userPaymentHistory;
  String? flag;

  GroupPaymentModel({this.userPaymentHistory, this.flag});

  GroupPaymentModel.fromJson(Map<String, dynamic> json) {
    if (json['user_payment_history'] != null) {
      userPaymentHistory = <GroupPaymentHistory>[];
      json['user_payment_history'].forEach((v) {
        userPaymentHistory!.add(new GroupPaymentHistory.fromJson(v));
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

class GroupPaymentHistory {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  List<PaymentHistory>? paymentHistory;

  GroupPaymentHistory(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.paymentHistory});

  GroupPaymentHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    if (json['payment_history'] != null) {
      paymentHistory = <PaymentHistory>[];
      json['payment_history'].forEach((v) {
        paymentHistory!.add(new PaymentHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    if (this.paymentHistory != null) {
      data['payment_history'] =
          this.paymentHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentHistory {
  String? fldGroupId;
  String? fldTransactionId;
  String? fldAmount;
  String? fldPaymentDate;

  PaymentHistory(
      {this.fldGroupId,
        this.fldTransactionId,
        this.fldAmount,
        this.fldPaymentDate});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    fldGroupId = json['fld_group_id'];
    fldTransactionId = json['fld_transaction_id'];
    fldAmount = json['fld_amount'];
    fldPaymentDate = json['fld_payment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fld_group_id'] = this.fldGroupId;
    data['fld_transaction_id'] = this.fldTransactionId;
    data['fld_amount'] = this.fldAmount;
    data['fld_payment_date'] = this.fldPaymentDate;
    return data;
  }
}
