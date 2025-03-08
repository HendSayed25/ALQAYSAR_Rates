import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/rate_entity.dart';
import '../../domain/repository/customer_repository.dart';
import '../remote_data_source/customer_remote_data_source.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;

  CustomerRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Unit>> addCustomer(CustomerEntity customer) async{
    return await remoteDataSource.addCustomer(customer);
  }

  @override
  Future<Either<Failure, Unit>> addCustomerRate(RateEntity customerRate) async{
    return await remoteDataSource.addCustomerRate(customerRate);
  }

  @override
  Future<Either<Failure, Unit>> deleteCustomer(int id) async{
    return await remoteDataSource.deleteCustomer(id);
  }

  @override
  Future<Either<Failure, List<CustomerEntity>>> getCustomers(branch) async{
    return await remoteDataSource.getCustomers(branch);
  }

  @override
  Future<Either<Failure, CustomerEntity>> updateCustomerName(CustomerEntity customer) async{
    return await remoteDataSource.updateCustomerName(customer);
  }

  @override
  Future<Either<Failure, List<RateEntity>>> getAllRateForCustomer(int customerId)async{
    return await remoteDataSource.getAllRateForCustomer(customerId);
  }

  @override
  Future<Either<Failure, List<RateEntity>>> getAllRates(int branch) async {
    return await remoteDataSource.getAllRates(branch);
  }



}
