import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../entities/customer.dart';
import '../../repository/customer_repository.dart';

class GetCustomersUsecase {
  final CustomerRepository repository;

  GetCustomersUsecase(this.repository);

  Future<Either<Failure, List<Customer>>> call() async {
    return await repository.getCustomers();
  }
}