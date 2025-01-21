import 'package:alqaysar_rates/features/domain/entities/customer.dart';

class DataIntent {
  DataIntent._();

  static Customer? _customer;
  static String? _email;
  static String? _password;

  static void pushCustomer(Customer customer) => _customer = customer;

  static void pushEmail(String email) => _email = email;

  static void pushPassword(String password) => _password = password;

  static get customer => _customer;

  static get email => _email;

  static get password => _password;
}
