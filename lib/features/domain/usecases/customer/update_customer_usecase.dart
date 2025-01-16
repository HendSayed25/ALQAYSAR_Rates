import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../entities/customer.dart';
import '../../repository/customer_repository.dart';


class UpdateCustomerUsecase {
  final CustomerRepository repository;

  UpdateCustomerUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Customer customer) async {
    return await repository.updateCustomer(customer);
  }
}