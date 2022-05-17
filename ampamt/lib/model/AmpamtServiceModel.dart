class AmpamtServiceModel{
  String id;
  String serviceName;

  AmpamtServiceModel(this.id, this.serviceName);
  factory AmpamtServiceModel.fromJson(Map<String, dynamic> data) {
    return AmpamtServiceModel(
        data['id'],
        data['serviceName']
    );
  }

}