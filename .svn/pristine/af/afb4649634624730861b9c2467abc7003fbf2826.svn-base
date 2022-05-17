class SuccessModel {
  final String status;
  final String name;
  final String id;
  final String msg;
  final String activeFlag;
  final String emailId;
  final int count;
  final String accountType;
  final String otp;
  final String statusType;
  final String data;
  final String accountExists;
  final String orderId;
  final String paidFlag;
  final double amount;
  final String cashAccountId;
  final List<dynamic> documentsVerificationModelList;


  SuccessModel(this.status,this.name,this.id,this.msg,this.activeFlag,this.emailId,this.count,this.accountType,
      this.otp,this.statusType,this.data,this.accountExists,
      this.orderId,this.paidFlag,this.amount,this.cashAccountId, this.documentsVerificationModelList,);

  factory SuccessModel.fromMap(Map<String, dynamic> json) {
    return SuccessModel(
        json['status'],
        json['name'],
        json['id'],
        json['msg'],
        json['activeFlag'],
        json['emailId'],
        json['count'],
        json['accountType'],
        json['otp'],
        json['statusType'],
        json['data'],
        json['accountExists'],
        json['orderId'],
        json['paidFlag'],
        json['amount'],
        json['cashAccountId'],
        json['documentsVerificationModelList'],

    );
  }
  factory SuccessModel.fromJson(Map<String, dynamic> data) {
    return SuccessModel(
      data['status'],
      data['name'],
      data['id'],
      data['msg'],
      data['activeFlag'],
      data['emailId'],
      data['count'],
      data['accountType'],
      data['otp'],
      data['statusType'],
      data['data'],
      data['accountExists'],
      data['orderId'],
      data['paidFlag'],
      data['amount'],
      data['cashAccountId'],
      data['documentsVerificationModelList'],

    );
  }
}

class DocModelList {
  final String id;
  final String allDocUploaded;
  final String accountType;
  final String availableAmount;
  final String isLocationSelected;

  DocModelList(this.id, this.allDocUploaded, this.accountType,
      this.availableAmount, this.isLocationSelected);

  factory DocModelList.fromJson(Map<String, dynamic> data) {
    return DocModelList(
        data['id'],
        data['allDocUploaded'],
        data['accountType'],
        data['availableAmount'],
        data['isLocationSelected']
    );
  }

  factory DocModelList.fromMap(Map<String, dynamic> json) {
    return DocModelList(
        json['id'],
        json['allDocUploaded'],
        json['accountType'],
        json['availableAmount'],
        json['isLocationSelected']
    );
  }

}