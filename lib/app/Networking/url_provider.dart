class UrlProvider {
  static const String DOMAIN_RELEASE = "https://savepy.com/savepy-api/savepy_app_api.php?";
  static const String GET_REGISTRATION_URL = "check_registraion=1";
  static const String LOGIN="check_login=1";
  static const String MY_PROFILE="check_user=1";
  static const String deleteUser="user_delete=1";
  static const String groupList="check_group=1";
  static const String createGroup="add_group=1";
  static const String createInstallmentPlan="add_plan=1";
  static const String planList="check_plan=1=1";
  static const String memberList="group_member=1";
  static const String memberListOne="my_member=1";
  static const String addMember="add_member=1";
  static const String assignGroup="assign_group=1";
  static const String searchMember="search_member=1";
  static const String paymentHistory="view_payment_history=1";
  static const String paymentDue="installment_due=1";
  static const String groupPaymentHistory="group_payment_history=1";
  static const String setPriority="installment_award=1";
  static const String makePayment="update_transaction=1";
  static const String updateProfile="update_profile=1";
  static const String deleteMember="delete_group_member=1";
  static const String deleteGroup="delete_group=1";

  static String registerUrl() {
    return DOMAIN_RELEASE+""+GET_REGISTRATION_URL;
  }
  static String loginUrl() {
    return DOMAIN_RELEASE+""+LOGIN;
  }
  static String createGroupUrl() {
    return DOMAIN_RELEASE+""+createGroup;
  }
  static String myProfileUrl() {
    return DOMAIN_RELEASE+""+MY_PROFILE;
  }
  static String deleteUserUrl() {
    return DOMAIN_RELEASE+""+deleteUser;
  }
  static String groupListUrl() {
    return DOMAIN_RELEASE+""+groupList;
  }
  static String createPlanUrl() {
    return DOMAIN_RELEASE+""+createInstallmentPlan;
  }
  static String planListUrl() {
    return DOMAIN_RELEASE+""+planList;
  }
  static String memberListOneUrl() {
    return DOMAIN_RELEASE+""+memberListOne;
  }  static String memberListUrl() {
    return DOMAIN_RELEASE+""+memberList;
  }
  static String addMemberUrl() {
    return DOMAIN_RELEASE+""+addMember;
  }
  static String assignGroupUrl() {
    return DOMAIN_RELEASE+""+assignGroup;
  }
  static String searchMemberUrl() {
    return DOMAIN_RELEASE+""+searchMember;
  }
  static String paymentHistoryListUrl() {
    return DOMAIN_RELEASE+""+paymentHistory;
  }
  static String paymentDueListUrl() {
    return DOMAIN_RELEASE+""+paymentDue;
  }

  static String groupPaymentHistoryListUrl() {
    return DOMAIN_RELEASE+""+groupPaymentHistory;
  }
  static String setPriorityUrl() {
    return DOMAIN_RELEASE+""+setPriority;
  }
  static String makePaymentUrl() {
    return DOMAIN_RELEASE+""+makePayment;
  }
  static String updateProfileUrl() {
    return DOMAIN_RELEASE+""+updateProfile;
  }
  static String deleteMemberUrl() {
    return DOMAIN_RELEASE+""+deleteMember;
  }
  static String deleteGroupUrl() {
    return DOMAIN_RELEASE+""+deleteGroup;
  }

}