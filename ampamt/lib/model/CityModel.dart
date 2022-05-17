class CityModel{
  final String cityCode;
  final String stateCode;
  final String cityName;

  CityModel(this.cityCode, this.stateCode, this.cityName);
  factory CityModel.fromJson(Map<String, dynamic> data) {
    return CityModel(
        data['cityCode'],
        data['stateCode'],
        data['cityName'],
    );
  }

}