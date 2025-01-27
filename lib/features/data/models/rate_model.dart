import '../../domain/entities/rate_entity.dart';

class RateModel extends RateEntity {
  const RateModel({
    super.id,
    super.customerId,
    super.phone,
    required super.rate,
    super.comment,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json['id'],
      customerId: json['customer_id'],
      phone: json['phone'],
      rate: json['rate'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'phone': phone,
      'rate': rate,
      'comment': comment,
    };
  }

  RateEntity toEntity() {
    return RateEntity(
      id: id,
      customerId: customerId,
      phone: phone,
      rate: rate,
      comment: comment,
    );
  }

  static RateModel fromEntity(RateEntity entity) {
    return RateModel(
      id: entity.id,
      customerId: entity.customerId,
      phone: entity.phone,
      rate: entity.rate,
      comment: entity.comment,
    );
  }
}
