import 'package:alqaysar_rates/features/domain/entities/rate_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../core/error.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/usecases/customer/add_customer_rate_usecase.dart';
import '../../domain/usecases/customer/add_customer_usecase.dart';
import '../../domain/usecases/customer/delete_customer_usecase.dart';
import '../../domain/usecases/customer/get_customers_usecase.dart';
import '../../domain/usecases/customer/update_customer_name_usecase.dart';
import '../states/customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final GetCustomersUsecase getCustomersUsecase;
  final AddCustomerUsecase addCustomerUsecase;
  final AddCustomerRateUsecase addCustomerRateUsecase;
  final DeleteCustomerUsecase deleteCustomerUsecase;
  final UpdateCustomerNameUsecase updateCustomerNameUsecase;
  List<CustomerEntity> _allCustomers = [];

  CustomerCubit({
    required this.deleteCustomerUsecase,
    required this.updateCustomerNameUsecase,
    required this.getCustomersUsecase,
    required this.addCustomerUsecase,
    required this.addCustomerRateUsecase,
  }) : super(CustomerInitial());

  Future<void> fetchCustomers() async {
    emit(CustomerLoading());
    final Either<Failure, List<CustomerEntity>> result =
        await getCustomersUsecase();
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (customers) {
        _allCustomers = customers;
        emit(CustomerLoaded(customers));
      },
    );
  }

  Future<void> addNewCustomer(CustomerEntity customer) async {
    emit(CustomerLoading());
    final Either<Failure, Unit> result = await addCustomerUsecase(customer);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (_) async {
        emit(CustomerAddedSuccessfully());
        fetchCustomers();
      },
    );
  }

  Future<void> deleteCustomer(int customerId) async {
    emit(CustomerLoading());
    final Either<Failure, Unit> result =
        await deleteCustomerUsecase(customerId);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (_) {
        emit(CustomerDeletedSuccessfully());
        fetchCustomers();
      },
    );
  }

  Future<void> updateCustomerName(CustomerEntity customer) async {
    emit(CustomerLoading());
    final Either<Failure, Unit> result =
        await updateCustomerNameUsecase(customer);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (_) {
        emit(CustomerNameUpdatedSuccessfully());
        fetchCustomers();
      },
    );
  }

  Future<void> updateCustomerRating(RateEntity customer) async {
    emit(CustomerLoading());
    final Either<Failure, Unit> result = await addCustomerRateUsecase(customer);

    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (_) {
        emit(CustomerRateUpdatedSuccessfully());
        fetchCustomers();
      },
    );
  }

  void filterCustomers(String query) {
    if (query.isEmpty) {
      emit(CustomerLoaded(_allCustomers));
    } else {
      final filteredCustomers = _allCustomers
          .where((customer) => (customer.name)
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      emit(CustomerLoaded(filteredCustomers));
    }
  }

void selectRatingCategory(String category) {
  emit(RatingCategorySelected(category));
}

void updatePhoneNumber(PhoneNumber phoneNumber) {
  emit(RatingPhoneNumberUpdated(phoneNumber));
}

// Future<void> getCustomerById(int customerId) async {
//   emit(CustomerLoading());
//   try {
//     final customer = _allCustomers.firstWhere(
//       (customer) => customer.id == customerId,
//       orElse: () => throw Exception("Customer not found"),
//     );
//     emit(CustomerLoaded([customer]));
//   } catch (e) {
//     emit(CustomerError("Customer with ID $customerId not found."));
//   }
// }
}
