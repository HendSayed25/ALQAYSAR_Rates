
import '../../domain/entities/customer.dart';

class CustomerModel extends Customer {
  CustomerModel({
    super.id,
    required super.uncooperative,
    required super.poor,
    required super.good,
    required super.veryGood,
    required super.excellent,
    required super.name,
    required super.userId,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      uncooperative: json['uncooperative'],
      poor: json['poor'],
      good: json['good'],
      veryGood: json['very_good'],
      excellent: json['excellent'],
      name: json['name'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uncooperative': uncooperative,
      'poor': poor,
      'good': good,
      'very_good': veryGood,
      'excellent': excellent,
      'name': name,
      'user_id': userId,
    };
  }
}