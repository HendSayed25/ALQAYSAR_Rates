import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../entities/rate_entity.dart';
import '../../repository/customer_repository.dart';

class AddCustomerRateUsecase {
  final CustomerRepository repository;

  AddCustomerRateUsecase(this.repository);

  Future<Either<Failure, Unit>> call(RateEntity customer) async {
    return await repository.addCustomerRate(customer);
  }
}