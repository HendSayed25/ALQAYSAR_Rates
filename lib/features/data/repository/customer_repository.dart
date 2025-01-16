import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repository/customer_repository.dart';
import '../remote_data_source/customer_remote_data_source.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;

  CustomerRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Customer>>> getCustomers() async {
    return await remoteDataSource.getCustomers();
  }

  @override
  Future<Either<Failure, Unit>> addCustomer(Customer customer) async {
    return await remoteDataSource.addCustomer(customer);
  }

  @override
  Future<Either<Failure, Unit>> updateCustomer(Customer customer) async {
    return await remoteDataSource.updateCustomer(customer);
  }

  @override
  Future<Either<Failure, Unit>> deleteCustomer(int id) async {
    return await remoteDataSource.deleteCustomer(id);
  }
}
