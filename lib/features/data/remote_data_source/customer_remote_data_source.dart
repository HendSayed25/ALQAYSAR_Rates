import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../core/error.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/rate_entity.dart';
import '../models/customer_model.dart';
import '../../../core/config/supabase/supabase_client.dart';
import '../models/rate_model.dart';
import 'package:http/http.dart' as http;

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
      await SupabaseClientProvider.client.from('rates').delete().eq('customer_id', id);
      await SupabaseClientProvider.client.from('customers').delete().eq('id', id);
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
      if(customerRate.rate=='poor'||customerRate.rate=='uncooperative'){
        final adminTokenResult = await getAdminTokens();

        adminTokenResult.fold(
              (failure) => logger.e("Error fetching admin token: ${failure.message}"),
              (adminToken) async {
            if (adminToken != null) {
              await sendNotificationToAdmin(adminToken[0]);
              print(adminToken);
            } else {
              logger.e("Admin token is null.");
            }
          },
        );
      }
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


  Future<void> sendNotificationToAdmin(String adminToken) async {
    final response = await http.post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'os_v2_app_lycc6b5d35gfxmintlxfqro5onka7kviqciuklmmj6nr77b7wrwuavzhleuwobuegnk5fui2dpdidpv62yasylmp6kgp7b3maj57w5a',
      },
      body: jsonEncode(<String, dynamic>{
        'app_id': '5e042f07-a3df-4c5b-b10d-9aee5845dd73',
        'include_player_ids': [adminToken], // أو استخدم player_ids للأدمن
        'contents': {'en': 'تم استلام تقييم ضعيف من أحد المستخدمين '},
        'headings': {'en': 'تنبيه: تقييم ضعيف'},
        // 'data':{'screen':'negativeScreen'},//to navigate to specific screen when click to notification
      }),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAdminTokens() async {
    try {
      final response = await SupabaseClientProvider.client
          .from('users')
          .select('token')
          .eq('role', 'admin');

      final List<Map<String, dynamic>> data = response;
      // Convert to List<String>, filtering out null tokens
      final tokens = data
          .map((user) => user['token'] as String?)
          .where((token) => token != null)
          .cast<String>() // Ensure list contains only non-null Strings
          .toList();

      if (tokens.isEmpty) {
        return const Left(ServerFailure("No admin tokens found"));
      }
      return Right(tokens);
    } catch (e) {
      logger.e("Failed to fetch admin tokens: $e");
      return const Left(ServerFailure("Failed to fetch admin tokens"));
    }
  }

}