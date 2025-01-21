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
            uncooperative: customer.uncooperative ?? 0,
            poor: customer.poor ?? 0,
            good: customer.good ?? 0,
            veryGood: customer.veryGood ?? 0,
            excellent: customer.excellent ?? 0,
            name: customer.name?.trim(),
            comments: null,
          ).toJson());
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
      await SupabaseClientProvider.client
          .from('customer')
          .delete()
          .eq('id', id);
      return const Right(unit);
    } catch (e) {
      logger.e("Error deleting customer: $e");
      return const Left(ServerFailure("Failed to delete customer"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCustomer(Customer customer) async {
    logger.i("Updating customer with name: ${customer.name}");
    //logger.i("Updating customer with id: ${customer.id}");

    try {
      final response = await SupabaseClientProvider.client
          .from('customer')
          .select()
          .eq('id', customer.id!)
          .single();

      final oldCustomer = CustomerModel.fromJson(response);

      final updatedCustomer = CustomerModel(
        id: customer.id,
        uncooperative: customer.uncooperative,
        poor: customer.poor,
        good: customer.good,
        veryGood: customer.veryGood,
        excellent: customer.excellent,
        name: customer.name,
        comments: customer.comments,
      );

      final newCustomer = updateRate(oldCustomer, updatedCustomer);

      await SupabaseClientProvider.client
          .from('customer')
          .update({
        ...newCustomer.toJson(),
        'comments': newCustomer.comments,
      })
          .eq('id', customer.id!);

      return const Right(unit);
    } catch (e) {
      logger.e("Error updating customer: $e");
      return const Left(ServerFailure("Failed to update customer"));
    }
  }

  CustomerModel updateRate(CustomerModel customer, CustomerModel newCustomer) {
    return CustomerModel(
      id: newCustomer.id,
      uncooperative:
          (newCustomer.uncooperative ?? 0) + (customer.uncooperative ?? 0),
      poor: (newCustomer.poor ?? 0) + (customer.poor ?? 0),
      good: (newCustomer.good ?? 0) + (customer.good ?? 0),
      veryGood: (newCustomer.veryGood ?? 0) + (customer.veryGood ?? 0),
      excellent: (newCustomer.excellent ?? 0) + (customer.excellent ?? 0),
      name: newCustomer.name,
      comments: [
        ...customer.comments ?? [],
        ...newCustomer.comments ?? [],
      ],
    );
  }
}
