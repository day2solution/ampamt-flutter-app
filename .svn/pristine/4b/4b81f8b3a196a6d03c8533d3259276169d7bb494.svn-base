class AmpamtCashAccountModel{
  final String cashAccountId;
  final String accountId;
  final String updatedBy;
  final double availableAmount;
  final String createDate;
  final String updateDate;

  AmpamtCashAccountModel(this.cashAccountId, this.accountId, this.updatedBy, this.availableAmount, this.createDate, this.updateDate);
  factory AmpamtCashAccountModel.fromJson(Map<String, dynamic> data) {
    return AmpamtCashAccountModel(
        data['cashAccountId'],
        data['accountId'],
        data['updatedBy'],
        data['availableAmount'],
        data['createDate'],
        data['updateDate']
    );
  }

}