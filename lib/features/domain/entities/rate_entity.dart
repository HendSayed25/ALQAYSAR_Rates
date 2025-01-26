class RateEntity {
  final int? id;
  final int? customerId;
  final String? phone;
  final String rate;
  final String? comment;

  const RateEntity({
    this.id,
    this.customerId,
    this.phone,
    required this.rate,
    this.comment,
  });
}
