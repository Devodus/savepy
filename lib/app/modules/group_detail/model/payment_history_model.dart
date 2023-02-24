class PaymentHistoryModel {
  List<UserPaymentHistory>? userPaymentHistory;
  String? flag;

  PaymentHistoryModel({this.userPaymentHistory, this.flag});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? fldTransactionId;
  String? fldAmount;
  String? fldPaymentDate;

  UserPaymentHistory(
      {this.id, this.fldTransactionId, this.fldAmount, this.fldPaymentDate});

  UserPaymentHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fldTransactionId = json['fld_transaction_id'];
    fldAmount = json['fld_amount'];
    fldPaymentDate = json['fld_payment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fld_transaction_id'] = this.fldTransactionId;
    data['fld_amount'] = this.fldAmount;
    data['fld_payment_date'] = this.fldPaymentDate;
    return data;
  }
}
