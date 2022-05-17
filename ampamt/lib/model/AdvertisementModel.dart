class AdvertisementModel{
  final String advId;
  final String accountId;
  final String createDate;
  final String displayFlag ;
  final String imageName;
  final String extras;

  AdvertisementModel(this.advId, this.accountId, this.createDate, this.displayFlag, this.imageName, this.extras);
  factory AdvertisementModel.fromJson(Map<String, dynamic> data) {
    return AdvertisementModel(
      data['advId'],
      data['accountId'],
      data['createDate'],
      data['displayFlag'],
      data['imageName'],
      data['extras']
    );
  }

}