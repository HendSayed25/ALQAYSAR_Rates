import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../entities/customer_entity.dart';
import '../entities/rate_entity.dart';

abstract class CustomerRepository {
  Future<Either<Failure, List<CustomerEntity>>> getCustomers();
  Future<Either<Failure, Unit>> addCustomer(CustomerEntity customer);
  Future<Either<Failure, CustomerEntity>> updateCustomerName(CustomerEntity customer);
  Future<Either<Failure, Unit>> addCustomerRate(RateEntity customerRate);
  Future<Either<Failure, Unit>> deleteCustomer(int id);
  Future<Either<Failure, List<RateEntity>>> getAllRateForCustomer(int customerId);
  Future<Either<Failure, List<RateEntity>>> getAllRates();
}