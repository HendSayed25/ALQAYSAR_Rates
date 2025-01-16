import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../entities/customer.dart';

abstract class CustomerRepository {
  Future<Either<Failure, List<Customer>>> getCustomers();
  Future<Either<Failure, Unit>> addCustomer(Customer customer);
  Future<Either<Failure, Unit>> updateCustomer(Customer customer);
  Future<Either<Failure, Unit>> deleteCustomer(int id);
}