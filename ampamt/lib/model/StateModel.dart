class StateModel{
  final String stateCode;
  final String stateName;
  final String stateCountry;
  final String expanded ;

  StateModel(this.stateCode, this.stateName, this.stateCountry, this.expanded);
  factory StateModel.fromJson(Map<String, dynamic> data) {
    return StateModel(
        data['stateCode'],
        data['stateName'],
        data['stateCountry'],
        data['expanded']

    );
  }

}