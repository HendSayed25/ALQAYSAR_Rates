import '../../domain/entities/rate_entity.dart';

class RateModel extends RateEntity {
  const RateModel({
    super.id,
    super.customerId,
    super.phone,
    required super.rate,
    super.comment,
    super.timestamp,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json['id'],
      customerId: json['customer_id'],
      phone: json['phone'],
      rate: json['rate'],
      comment: json['comment'],
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'phone': phone,
      'rate': rate,
      'comment': comment,
      'timestamp': timestamp?.toIso8601String(),
    };
  }

  RateEntity toEntity() {
    print("Converting to RateEntity: id=$id, customerId=$customerId, rate=$rate");

    return RateEntity(
      id: id,
      customerId: customerId,
      phone: phone,
      rate: rate,
      comment: comment,
      timestamp: timestamp,
    );
  }

  static RateModel fromEntity(RateEntity entity) {
    return RateModel(
      id: entity.id,
      customerId: entity.customerId,
      phone: entity.phone,
      rate: entity.rate,
      comment: entity.comment,
      timestamp: entity.timestamp,
    );
  }
}
