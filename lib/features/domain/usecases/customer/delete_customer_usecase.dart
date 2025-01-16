import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../repository/customer_repository.dart';


class DeleteCustomerUsecase {
  final CustomerRepository repository;

  DeleteCustomerUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteCustomer(id);
  }
}