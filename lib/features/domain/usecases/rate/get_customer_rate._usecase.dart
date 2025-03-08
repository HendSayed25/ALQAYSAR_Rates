import 'package:alqaysar_rates/core/error.dart';
import 'package:alqaysar_rates/features/domain/entities/rate_entity.dart';
import 'package:alqaysar_rates/features/domain/repository/customer_repository.dart';
import 'package:dartz/dartz.dart';

class GetCustomerRateUseCase{
final CustomerRepository repository;

GetCustomerRateUseCase(this.repository);

Future <Either<Failure,List<RateEntity>>> call(int customerId) async{
  return await repository.getAllRateForCustomer(customerId);
}

Future<Either<Failure, List<RateEntity>>> call2(int branch) async {
  return await repository.getAllRates(branch);

}


}