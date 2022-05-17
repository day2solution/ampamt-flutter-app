class DocumentsVerificationModel{
  final String id;
  final String allDocUploaded;
  final String accountType;
  final String availableAmount;
  final String isLocationSelected;

  DocumentsVerificationModel(this.id, this.allDocUploaded, this.accountType, this.availableAmount, this.isLocationSelected);

  factory DocumentsVerificationModel.fromJson(Map<String, dynamic> data) {
    return DocumentsVerificationModel(
      data['id'],
      data['allDocUploaded'],
      data['accountType'],
      data['availableAmount'],
      data['isLocationSelected'],
    );

  }
}