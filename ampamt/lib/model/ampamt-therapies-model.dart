class AmpamtTherapiesModel{
  String therapyId;
  String therapyName;
  String activeFlag;

  AmpamtTherapiesModel(this.therapyId, this.therapyName, this.activeFlag);
  factory AmpamtTherapiesModel.fromJson(Map<String, dynamic> data) {
    return AmpamtTherapiesModel(
        data['therapyId'],
        data['therapyName'],
        data['activeFlag']

    );
  }
}