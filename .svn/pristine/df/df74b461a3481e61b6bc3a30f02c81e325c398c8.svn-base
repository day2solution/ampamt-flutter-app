class AdvertisementsModel{
  final String advId;
  final String accountId;
  final String createDate;
  final String displayFlag;
  final String imageName;
  final String extras;

  AdvertisementsModel(this.advId, this.accountId, this.createDate, this.displayFlag, this.imageName, this.extras);
  factory AdvertisementsModel.fromJson(Map<String, dynamic> data) {
    return AdvertisementsModel(
      data['advId'],
      data['accountId'],
      data['createDate'],
      data['displayFlag'],
      data['imageName'],
      data['extras'],
    );
  }
}