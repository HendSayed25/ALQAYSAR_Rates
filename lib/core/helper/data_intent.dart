import 'package:alqaysar_rates/features/domain/entities/customer_entity.dart';

class DataIntent {
  DataIntent._();

  static CustomerEntity _customer = CustomerEntity(name: "",branch: 1);
  static String? _email;
  static String? _password;

  static void pushCustomer(CustomerEntity customer) => _customer = customer;

  static void pushEmail(String email) => _email = email;

  static void pushPassword(String password) => _password = password;

  static get customer => _customer;

  static get email => _email;

  static get password => _password;
}
