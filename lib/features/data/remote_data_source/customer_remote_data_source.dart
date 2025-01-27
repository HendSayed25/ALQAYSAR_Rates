import 'dart:convert';

import 'package:alqaysar_rates/features/data/models/rate_model.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../core/error.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/rate_entity.dart';
import '../models/customer_model.dart';
import '../../../core/config/supabase/supabase_client.dart';

abstract class CustomerRemoteDataSource {
  Future<Either<Failure, List<CustomerEntity>>> getCustomers();
  Future<Either<Failure, Unit>> addCustomer(CustomerEntity customer);
  Future<Either<Failure, Unit>> updateCustomerName(CustomerEntity customer);
  Future<Either<Failure, Unit>> addCustomerRate(RateEntity customerRate);
  Future<Either<Failure, Unit>> deleteCustomer(int id);
  Future<Either<Failure,List<RateEntity>>> getAllRateForCustomer(int id);
  Future<Either<Failure, List<RateEntity>>> getAllRates();
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final Logger logger = Logger();

  @override
  Future<Either<Failure, List<CustomerEntity>>> getCustomers() async {
    try {
      final response = await SupabaseClientProvider.client.from('customers').select();
      final customers = response.map((json) => CustomerModel.fromJson(json).toEntity()).toList();
      return Right(customers);
    } catch (e) {
      logger.e("Error fetching customers: $e");
      return const Left(ServerFailure("Failed to fetch customers"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addCustomer(CustomerEntity customer) async {
    try {
      await SupabaseClientProvider.client.from('customers').insert(CustomerModel.fromEntity(customer).toJson());
      return const Right(unit);
    } catch (e) {
      logger.e("Error adding customer: $e");
      return const Left(ServerFailure("Failed to add customer"));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCustomer(int id) async {
    logger.i("Deleting customer with id: $id");
    try {
      await SupabaseClientProvider.client.from('customers').delete().eq('id', id);
      await SupabaseClientProvider.client.from('rates').delete().eq('customer_id', id);
      return const Right(unit);
    } catch (e) {
      logger.e("Error deleting customer: $e");
      return const Left(ServerFailure("Failed to delete customer"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCustomerName(CustomerEntity customer) async {
    logger.i("Updating customer with name: ${customer.name}");
    final newCustomer = CustomerModel.fromEntity(customer);
    try {
      await SupabaseClientProvider.client
          .from('customers')
          .update(newCustomer.toJson())
          .eq('id', customer.id!);
      return const Right(unit);
    } catch (e) {
      logger.e("Error updating customer name : $e");
      return const Left(ServerFailure("Failed to update customer name"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addCustomerRate(RateEntity customerRate) async {
    try {
      await SupabaseClientProvider.client.from('rates').insert(RateModel.fromEntity(customerRate).toJson());
      return const Right(unit);
    } catch (e) {
      logger.e("Error adding customer rate: $e");
      return const Left(ServerFailure("Failed to add customer rate"));
    }
  }

  @override
  Future<Either<Failure, List<RateEntity>>> getAllRateForCustomer(int customerId) async{
    try {
      final response = await SupabaseClientProvider.client.from('rates').select().eq('customer_id', customerId);
      final rates = response.map((json) => RateModel.fromJson(json).toEntity()).toList();
      return Right(rates);
    } catch (e) {
      logger.e("Error getting customer rate: $e");
      return const Left(ServerFailure("Failed to get customer rate"));
    }
  }
  // @override
  // Future<Either<Failure, List<RateEntity>>> getAllRates() async {
  //   try {
  //     final response = await SupabaseClientProvider.client
  //         .from('rates')
  //         .select();
  //
  //     final rates = response.map((json) => RateModel.fromJson(json).toEntity()).toList();
  //     return Right(rates);
  //   } catch (e) {
  //     logger.e("Error getting customer rate: $e");
  //     return const Left(ServerFailure("Failed to get customer rate"));
  //   }
  // }
  Future<Either<Failure, List<RateEntity>>> getAllRates() async {
    try {
      final response = await SupabaseClientProvider.client
          .from('rates')
          .select('rate, customers(name),comment,phone')
          .or('rate.eq.poor,rate.eq.uncooperative');

      final List<RateEntity>rates = response.map((rate) {
        return RateEntity(
          rate: rate['rate'],
          customerName: rate['customers']['name'],
          phone: rate['phone'],
          comment: rate['comment']
        );
      }).toList();

      return Right(rates);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }






}