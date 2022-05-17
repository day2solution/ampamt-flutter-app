class BusinessDocumentUploadModel{
  final String imageBase64;
  final String imageName;
  final String userId;
  final String documentId;
  final String id;
  final String companyLogo;
  final String qualiCertificate1;
  final String qualiCertificate2;
  final String qualiCertificate3;
  final String qualiCertificate4;
  final String qualiCertificate5;
  final String qualiCertificate6;
  final String msmeCertificate;
  final String profCertificate;
  final String companyPan;
  final String companyAadhar;
  final String companyAadharBack;
  final String gumastaCertificate;
  final String isoCertificate;
  final String gstCertificate;
  final String complianceCertificate;
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
  final String aboutCompany;
  final String detailAboutProduct;

  final String companyLogoBase64;
  final String qualiCertificate1Base64;
  final String qualiCertificate2Base64;
  final String qualiCertificate3Base64;
  final String qualiCertificate4Base64;
  final String qualiCertificate5Base64;
  final String qualiCertificate6Base64;
  final String msmeCertificateBase64;
  final String profCertificateBase64;
  final String companyPanBase64;
  final String companyAadharBase64;
  final String companyAadharBackBase64;
  final String gumastaCertificateBase64;
  final String isoCertificateBase64;
  final String gstCertificateBase64;
  final String complianceCertificateBase64;
  final String otherLicCertificate1Base64;
  final String otherLicCertificate2Base64;
  final String otherLicCertificate3Base64;
  final String professionalWorkimg1Base64;
  final String professionalWorkimg2Base64;
  final String professionalWorkimg3Base64;

  BusinessDocumentUploadModel(this.imageBase64, this.imageName, this.userId, this.documentId, this.id, this.companyLogo, this.qualiCertificate1, this.qualiCertificate2, this.qualiCertificate3, this.qualiCertificate4, this.qualiCertificate5, this.qualiCertificate6, this.msmeCertificate, this.profCertificate, this.companyPan, this.companyAadhar, this.companyAadharBack, this.gumastaCertificate, this.isoCertificate, this.gstCertificate, this.complianceCertificate, this.otherLicCertificate1, this.otherLicCertificate2, this.otherLicCertificate3, this.professionalWorkimg1, this.professionalWorkimg2, this.professionalWorkimg3, this.websiteLink, this.facebookLink, this.instagramLink, this.youtubeLink, this.twitterLink, this.aboutCompany, this.detailAboutProduct, this.companyLogoBase64, this.qualiCertificate1Base64, this.qualiCertificate2Base64, this.qualiCertificate3Base64, this.qualiCertificate4Base64, this.qualiCertificate5Base64, this.qualiCertificate6Base64, this.msmeCertificateBase64, this.profCertificateBase64, this.companyPanBase64, this.companyAadharBase64, this.companyAadharBackBase64, this.gumastaCertificateBase64, this.isoCertificateBase64, this.gstCertificateBase64, this.complianceCertificateBase64, this.otherLicCertificate1Base64, this.otherLicCertificate2Base64, this.otherLicCertificate3Base64, this.professionalWorkimg1Base64, this.professionalWorkimg2Base64, this.professionalWorkimg3Base64);

  factory BusinessDocumentUploadModel.fromJson(Map<String, dynamic> data) {
    return BusinessDocumentUploadModel(
      data['imageBase64'],
      data['imageName'],
      data['userId'],
      data['documentId'],
      data['id'],
      data['companyLogo'],
      data['qualiCertificate1'],
      data['qualiCertificate2'],
      data['qualiCertificate3'],
      data['qualiCertificate4'],
      data['qualiCertificate5'],
      data['qualiCertificate6'],
      data['msmeCertificate'],
      data['profCertificate'],
      data['companyPan'],
      data['companyAadhar'],
      data['companyAadharBack'],
      data['gumastaCertificate'],
      data['isoCertificate'],
      data['gstCertificate'],
      data['complianceCertificate'],
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
      data['aboutCompany'],
      data['detailAboutProduct'],

      data['companyLogoBase64'],
      data['qualiCertificate1Base64'],
      data['qualiCertificate2Base64'],
      data['qualiCertificate3Base64'],
      data['qualiCertificate4Base64'],
      data['qualiCertificate5Base64'],
      data['qualiCertificate6Base64'],
      data['msmeCertificateBase64'],
      data['profCertificateBase64'],
      data['companyPanBase64'],
      data['companyAadharBase64'],
      data['companyAadharBackBase64'],
      data['gumastaCertificateBase64'],
      data['isoCertificateBase64'],
      data['gstCertificateBase64'],
      data['complianceCertificateBase64'],
      data['otherLicCertificate1Base64'],
      data['otherLicCertificate2Base64'],
      data['otherLicCertificate3Base64'],
      data['professionalWorkimg1Base64'],
      data['professionalWorkimg2Base64'],
      data['professionalWorkimg3Base64'],

    );

  }

}