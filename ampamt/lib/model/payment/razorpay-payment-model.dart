class RazorpayPaymentModel{
  final String code;
  final String description;
  final String source;
  final String step;
  final String reason;

  RazorpayPaymentModel(this.code, this.description, this.source, this.step, this.reason);

  factory RazorpayPaymentModel.fromJson(Map<String, dynamic> data) {
    return RazorpayPaymentModel(
        data['code'],
        data['description'],
        data['source'],
        data['step'],
        data['reason']
    );
  }

}
class RazorpayPaymentModelError{
  final RazorpayPaymentModel error;

  RazorpayPaymentModelError(this.error);
  factory RazorpayPaymentModelError.fromJson(Map<String, dynamic> data) {
    return RazorpayPaymentModelError(
      RazorpayPaymentModel.fromJson(data['error']),
    );
  }
}