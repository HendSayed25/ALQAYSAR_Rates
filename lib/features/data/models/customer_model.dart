import '../../domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  const CustomerModel({
    required super.id,
    required super.name,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  CustomerEntity toEntity() {
    return CustomerEntity(
      id: id,
      name: name,
    );
  }

  static CustomerModel fromEntity(CustomerEntity entity) {
    return CustomerModel(
      id: entity.id,
      name: entity.name,
    );
  }

}