class AppUpdateModel{
final int version;
final String name;
final String versionName;

  AppUpdateModel(this.version, this.name,this.versionName);
factory AppUpdateModel.fromJson(Map<String, dynamic> data) {
  return AppUpdateModel(
      data['version'],
      data['name'],
      data['versionName']

  );
}
}