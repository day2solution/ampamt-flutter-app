class DoctorDocumentsModel{
  final String documentId;
  final String id;
  final String profilePic;
  final String aadhar;
  final String aadharBack;
  final String panFront;
  final String panBack;
  final String qualiCertificate1;
  final String qualiCertificate2;
  final String qualiCertificate3;
  final String qualiCertificate4;
  final String qualiCertificate5;
  final String qualiCertificate6;
  final String rampCertificate;
  final String profCertificate;
  final String healthDepCertificate;
  final String ayushDepRegistration;
  final String otherLicCertificate1;
  final String otherLicCertificate2;
  final String otherLicCertificate3;
  final String professionalWorkimg1;
  final String professionalWorkimg2;
  final String professionalWorkimg3;
  final String websiteLink;
  final String facebookLink;
  final String instagramLink;
  final String youtubeLink;
  final String twitterLink;
  final String experienceComments;
  final String achievementsComments;
  final String mediCouncilRegistration;
  final String signatureImg;
  final String profilePicB64Img;
  final String aadharImgBase64;
  final String aadharBackImgBase64;
  final String panBackImgBase64 ;
  final String panFrontImgBase64;
  final String qualiCertificate1B64Img;
  final String qualiCertificate2B64Img;
  final String qualiCertificate3B64Img;
  final String qualiCertificate4B64Img;
  final String qualiCertificate5B64Img;
  final String qualiCertificate6B64Img;
  final String rampCertificateB64Img;
  final String profCertificateB64Img;
  final String healthDepCertificateB64Img;
  final String ayushDepRegistrationB64Img;
  final String otherLicCertificate1B64Img;
  final String otherLicCertificate2B64Img;
  final String otherLicCertificate3B64Img;
  final String professionalWorkimg1B64Img;
  final String professionalWorkimg2B64Img;
  final String professionalWorkimg3B64Img;
  final String signatureB64Img;
  final String medicalCouncilB64Img;

  DoctorDocumentsModel(this.documentId, this.id, this.profilePic, this.aadhar,this.aadharBack, this.panFront, this.panBack, this.qualiCertificate1, this.qualiCertificate2, this.qualiCertificate3, this.qualiCertificate4,
  this.qualiCertificate5, this.qualiCertificate6, this.rampCertificate, this.profCertificate, this.healthDepCertificate, this.ayushDepRegistration, this.otherLicCertificate1,
  this.otherLicCertificate2, this.otherLicCertificate3, this.professionalWorkimg1, this.professionalWorkimg2, this.professionalWorkimg3, this.websiteLink, this.facebookLink,
  this.instagramLink, this.youtubeLink, this.twitterLink, this.experienceComments, this.achievementsComments, this.mediCouncilRegistration, this.signatureImg, this.profilePicB64Img,
  this.aadharImgBase64,this.aadharBackImgBase64, this.panBackImgBase64, this.panFrontImgBase64, this.qualiCertificate1B64Img, this.qualiCertificate2B64Img, this.qualiCertificate3B64Img, this.qualiCertificate4B64Img,
  this.qualiCertificate5B64Img, this.qualiCertificate6B64Img, this.rampCertificateB64Img, this.profCertificateB64Img, this.healthDepCertificateB64Img, this.ayushDepRegistrationB64Img,
  this.otherLicCertificate1B64Img, this.otherLicCertificate2B64Img, this.otherLicCertificate3B64Img, this.professionalWorkimg1B64Img, this.professionalWorkimg2B64Img, this.professionalWorkimg3B64Img,
  this.signatureB64Img, this.medicalCouncilB64Img);

  factory DoctorDocumentsModel.fromJson(Map<String, dynamic> data) {
    return DoctorDocumentsModel(
      data['documentId'],
      data['id'],
      data['profilePic'],
      data['aadhar'],
      data['aadharBack'],
      data['panFront'],
      data['panBack'],
      data['qualiCertificate1'],
      data['qualiCertificate2'],
      data['qualiCertificate3'],
      data['qualiCertificate4'],
      data['qualiCertificate5'],
      data['qualiCertificate6'],
      data['rampCertificate'],
      data['profCertificate'],
      data['healthDepCertificate'],
      data['ayushDepRegistration'],
      data['otherLicCertificate1'],
      data['otherLicCertificate2'],
      data['otherLicCertificate3'],
      data['professionalWorkimg1'],
      data['professionalWorkimg2'],
      data['professionalWorkimg3'],
      data['websiteLink'],
      data['facebookLink'],
      data['instagramLink'],
      data['youtubeLink'],
      data['twitterLink'],
      data['experienceComments'],
      data['achievementsComments'],
      data['mediCouncilRegistration'],
      data['signatureImg'],
      data['profilePicB64Img'],
      data['aadharImgBase64'],
      data['aadharBackImgBase64'],
      data['panBackImgBase64 '],
      data['panFrontImgBase64'],
      data['qualiCertificate1B64Img'],
      data['qualiCertificate2B64Img'],
      data['qualiCertificate3B64Img'],
      data['qualiCertificate4B64Img'],
      data['qualiCertificate5B64Img'],
      data['qualiCertificate6B64Img'],
      data['rampCertificateB64Img'],
      data['profCertificateB64Img'],
      data['healthDepCertificateB64Img'],
      data['ayushDepRegistrationB64Img'],
      data['otherLicCertificate1B64Img'],
      data['otherLicCertificate2B64Img'],
      data['otherLicCertificate3B64Img'],
      data['professionalWorkimg1B64Img'],
      data['professionalWorkimg2B64Img'],
      data['professionalWorkimg3B64Img'],
      data['signatureB64Img'],
      data['medicalCouncilB64Img']
    );
  }
}