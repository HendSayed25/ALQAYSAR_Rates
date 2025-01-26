import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../entities/customer_entity.dart';
import '../../repository/customer_repository.dart';

class AddCustomerUsecase {
  final CustomerRepository repository;

  AddCustomerUsecase(this.repository);

  Future<Either<Failure, Unit>> call(CustomerEntity customer) async {
    return await repository.addCustomer(customer);
  }
}