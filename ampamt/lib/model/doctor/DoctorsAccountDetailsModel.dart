class DoctorsAccountDetailsModel{
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String nameTitle;
  final String gender;
  final String dob;
  final String bloodGroup;
  final String maritalStatus;
  final String practicingAs;
  final String practicing;
  final String practiceCity;
  final String nationality;
  final String religion;
  final String fatherName;
  final String motherName;
  final String companyName;
  final String experiencEstablishment;
  final String registOfficeAdd;
  final String contactNo;
  final String otherContactNo;
  final String whatsappNo;
  final String emergencyNo;
  final String emailId;
  final String aadharNo;
  final String panNo;
  final String passportNo;
  final String tncAccepted;
  final String activeFlag;
  final String status;
  final String accountType;
  final String createDate;
  final String wifeHusbandName;
  final String companyTitle;
  final String isAdmin;
  final String profilePic;
  final String haveRamp;
  final String applyRamp;
  final String permanentAddress;
  final String adminFlag;
  final String state;
  final String city;
  final String reference;
  final String country;
  final String zipCode;

  DoctorsAccountDetailsModel(this.id, this.firstName, this.middleName, this.lastName, this.nameTitle, this.gender, this.dob, this.bloodGroup, this.maritalStatus, this.practicingAs, this.practicing, this.practiceCity, this.nationality, this.religion, this.fatherName, this.motherName, this.companyName, this.experiencEstablishment, this.registOfficeAdd, this.contactNo, this.otherContactNo, this.whatsappNo, this.emergencyNo, this.emailId, this.aadharNo, this.panNo, this.passportNo, this.tncAccepted, this.activeFlag, this.status, this.accountType, this.createDate, this.wifeHusbandName, this.companyTitle, this.isAdmin, this.profilePic, this.haveRamp, this.applyRamp, this.permanentAddress, this.adminFlag, this.state, this.city, this.reference, this.country, this.zipCode);

  factory DoctorsAccountDetailsModel.fromJson(Map<String, dynamic> data) {
    return DoctorsAccountDetailsModel(
      data['id'],
      data['firstName'],
      data['middleName'],
      data['lastName'],
      data['nameTitle'],
      data['gender'],
      data['dob'],
      data['bloodGroup'],
      data['maritalStatus'],
      data['practicingAs'],
      data['practicing'],
      data['practiceCity'],
      data['nationality'],
      data['religion'],
      data['fatherName'],
      data['motherName'],
      data['companyName'],
      data['experiencEstablishment'],
      data['registOfficeAdd'],
      data['contactNo'],
      data['otherContactNo'],
      data['whatsappNo'],
      data['emergencyNo'],
      data['emailId'],
      data['aadharNo'],
      data['panNo'],
      data['passportNo'],
      data['tncAccepted'],
      data['activeFlag'],
      data['status'],
      data['accountType'],
      data['createDate'],
      data['wifeHusbandName'],
      data['companyTitle'],
      data['isAdmin'],
      data['profilePic'],
      data['haveRamp'],
      data['applyRamp'],
      data['permanentAddress'],
      data['adminFlag'],
      data['state'],
      data['city'],
      data['reference'],
      data['country'],
      data['zipCode'],

    );

  }
}