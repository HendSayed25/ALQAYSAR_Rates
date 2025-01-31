import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../entities/customer_entity.dart';
import '../../repository/customer_repository.dart';

class UpdateCustomerNameUsecase {
  final CustomerRepository repository;

  UpdateCustomerNameUsecase(this.repository);

  Future<Either<Failure, CustomerEntity>> call(CustomerEntity customer) async {
    return await repository.updateCustomerName(customer);
  }
}
