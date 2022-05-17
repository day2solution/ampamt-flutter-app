class UserSearchModel{
  final String id;
  final String accountType;
  final String name;
  final String nameTitle;
  final String gender;
  final String city;
  final String state;
  final String zipCode;
  final String emailId;
  final String contactNo;
  final String whatsappNo;
  final String emergencyNo;
  final String createDate;

  UserSearchModel(this.id, this.accountType, this.name, this.nameTitle, this.gender, this.city, this.state, this.zipCode, this.emailId, this.contactNo, this.whatsappNo, this.emergencyNo, this.createDate);
  factory UserSearchModel.fromJson(Map<String, dynamic> data) {
    return UserSearchModel(
      data['id'],
      data['accountType'],
      data['name'],
      data['nameTitle'],
      data['gender'],
      data['state'],
      data['city'],
      data['zipCode'],
      data['emailId'],
      data['contactNo'],
      data['whatsappNo'],
      data['emergencyNo'],
      data['createDate'],
    );
  }
}