import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../entities/customer.dart';
import '../../repository/customer_repository.dart';

class AddCustomerUsecase {
  final CustomerRepository repository;

  AddCustomerUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Customer customer) async {
    return await repository.addCustomer(customer);
  }
}