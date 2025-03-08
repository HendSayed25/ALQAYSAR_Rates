import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../entities/customer_entity.dart';
import '../../repository/customer_repository.dart';

class GetCustomersUsecase {
  final CustomerRepository repository;

  GetCustomersUsecase(this.repository);

  Future<Either<Failure, List<CustomerEntity>>> call(int branch) async {
    return await repository.getCustomers(branch);
  }
}