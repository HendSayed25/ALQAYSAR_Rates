class Customer {
  final int? id;
  final int? uncooperative;
  final int? poor;
  final int? good;
  final int? veryGood;
  final int? excellent;
  final String name;
  final String userId;

  Customer({
    this.id,
    this.uncooperative,
    this.poor,
    this.good,
    this.veryGood,
    this.excellent,
    required this.name,
    required this.userId,
  });

  double get rating {
    final total = uncooperative! + poor! + good! + veryGood! + excellent!;
    return (total == 0) ? 0.0 : total / 5;
  }
}
