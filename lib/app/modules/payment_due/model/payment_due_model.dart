class PaymentDueModel {
  String? message;
  List<Data>? data;
  String? flag;

  PaymentDueModel({this.message, this.data, this.flag});

  PaymentDueModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['flag'] = this.flag;
    return data;
  }
}

class Data {
  String? fldGroupId;
  String? fldGroupName;
  List<PlanData>? planData;
  List<PaymentData>? paymentData;

  Data({this.fldGroupId, this.fldGroupName, this.planData, this.paymentData});

  Data.fromJson(Map<String, dynamic> json) {
    fldGroupId = json['fld_group_id'];
    fldGroupName = json['fld_group_name'];
    if (json['plan_data'] != null) {
      planData = <PlanData>[];
      json['plan_data'].forEach((v) {
        planData!.add(new PlanData.fromJson(v));
      });
    }
    if (json['payment_data'] != null) {
      paymentData = <PaymentData>[];
      json['payment_data'].forEach((v) {
        paymentData!.add(new PaymentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fld_group_id'] = this.fldGroupId;
    data['fld_group_name'] = this.fldGroupName;
    if (this.planData != null) {
      data['plan_data'] = this.planData!.map((v) => v.toJson()).toList();
    }
    if (this.paymentData != null) {
      data['payment_data'] = this.paymentData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanData {
  String? planStartDate;
  String? fldPlanId;
  String? fldPlanName;
  String? fldDuration;
  String? fldStartDate;
  String? fldDueAmount;

  PlanData(
      {this.planStartDate,
        this.fldPlanId,
        this.fldPlanName,
        this.fldDuration,
        this.fldStartDate,
        this.fldDueAmount});

  PlanData.fromJson(Map<String, dynamic> json) {
    planStartDate = json['plan_start_date'];
    fldPlanId = json['fld_plan_id'];
    fldPlanName = json['fld_plan_name'];
    fldDuration = json['fld_duration'];
    fldStartDate = json['fld_start_date'];
    fldDueAmount = json['fld_due_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_start_date'] = this.planStartDate;
    data['fld_plan_id'] = this.fldPlanId;
    data['fld_plan_name'] = this.fldPlanName;
    data['fld_duration'] = this.fldDuration;
    data['fld_start_date'] = this.fldStartDate;
    data['fld_due_amount'] = this.fldDueAmount;
    return data;
  }
}

class PaymentData {
  String? fldPaymentStatus;
  String? fldPaymentDate;
  String? fldPayAmount;

  PaymentData({this.fldPaymentStatus, this.fldPaymentDate, this.fldPayAmount});

  PaymentData.fromJson(Map<String, dynamic> json) {
    fldPaymentStatus = json['fld_payment_status'];
    fldPaymentDate = json['fld_payment_date'];
    fldPayAmount = json['fld_pay_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fld_payment_status'] = this.fldPaymentStatus;
    data['fld_payment_date'] = this.fldPaymentDate;
    data['fld_pay_amount'] = this.fldPayAmount;
    return data;
  }
}
