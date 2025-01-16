import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../core/error.dart';
import '../../domain/entities/customer.dart';
import '../models/customer_model.dart';
import '../../../core/config/supabase/supabase_client.dart';

abstract class CustomerRemoteDataSource {
  Future<Either<Failure, List<Customer>>> getCustomers();
  Future<Either<Failure, Unit>> addCustomer(Customer customer);
  Future<Either<Failure, Unit>> updateCustomer(Customer customer);
  Future<Either<Failure, Unit>> deleteCustomer(int id);
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  var logger = Logger();

  @override
  Future<Either<Failure, List<Customer>>> getCustomers() async {
    try {
      final response =
      await SupabaseClientProvider.client.from('customer').select();
      final customers =
      response.map((json) => CustomerModel.fromJson(json)).toList();
      return Right(customers);
    } catch (e) {
      logger.e("Error fetching customers: $e");
      return const Left(ServerFailure("Failed to fetch customers"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addCustomer(Customer customer) async {
    try {
      await SupabaseClientProvider.client.from('customer').insert(CustomerModel(
        id: customer.id,
        uncooperative: customer.uncooperative,
        poor: customer.poor,
        good: customer.good,
        veryGood: customer.veryGood,
        excellent: customer.excellent,
        name: customer.name,
        userId: customer.userId,
      ).toJson());
      return const Right(unit);
    } catch (e) {
      logger.e("Error adding customer: $e");
      return const Left(ServerFailure("Failed to add customer"));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCustomer(int id) async {
    try {
      await SupabaseClientProvider.client.from('customer').delete().eq('id', id);
      return const Right(unit);
    } catch (e) {
      logger.e("Error deleting customer: $e");
      return const Left(ServerFailure("Failed to delete customer"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCustomer(Customer customer) async {
    try {
      await SupabaseClientProvider.client
          .from('customer')
          .update(CustomerModel(
        id: customer.id,
        uncooperative: customer.uncooperative,
        poor: customer.poor,
        good: customer.good,
        veryGood: customer.veryGood,
        excellent: customer.excellent,
        name: customer.name,
        userId: customer.userId,
      ).toJson())
          .eq('id', customer.id);
      return const Right(unit);
    } catch (e) {
      logger.e("Error updating customer: $e");
      return const Left(ServerFailure("Failed to update customer"));
    }
  }
}