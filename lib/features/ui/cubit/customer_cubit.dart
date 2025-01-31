import 'package:alqaysar_rates/features/domain/entities/rate_entity.dart';
import 'package:alqaysar_rates/features/domain/usecases/rate/get_customer_rate._usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../core/error.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/usecases/rate/add_customer_rate_usecase.dart';
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
  final GetCustomerRateUseCase getCustomerRateUseCase;
  List<CustomerEntity> _allCustomers = [];
  List<RateEntity> _allRates=[];

  CustomerCubit({
    required this.deleteCustomerUsecase,
    required this.updateCustomerNameUsecase,
    required this.getCustomersUsecase,
    required this.addCustomerUsecase,
    required this.addCustomerRateUsecase,
    required this.getCustomerRateUseCase,
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
    final Either<Failure, CustomerEntity> result =
        await updateCustomerNameUsecase(customer);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (c) {
        emit(CustomerNameUpdatedSuccessfully(c));
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

  Future<void> fetchCustomerRates(int customerId) async {
    emit(CustomerLoading());
    final Either<Failure, List<RateEntity>> result = await getCustomerRateUseCase.call(customerId);

    result.fold(
          (failure) => emit(CustomerError(failure.message)),
          (rates) {
        _allRates = rates;
        emit(CustomerRateLoaded(rates));
      },
    );
  }
  void fetchNegativeRates() async {
    try {
      emit(CustomerLoading());
      final Either<Failure, List<RateEntity>> result = await getCustomerRateUseCase.call2();

      result.fold(
            (failure) => emit(CustomerError('Failed to load negative rates: ${failure.message}')),
            (rates) {
          final negativeRates = rates.where((rate) =>
          rate.rate == 'poor' || rate.rate == 'uncooperative').toList();

          emit(CustomerRateLoaded(negativeRates));
        },
      );
    } catch (e) {
      emit(CustomerError('Failed to load negative rates: $e'));
    }
  }

  // Future<void> fetchCustomers() async {
  //   emit(CustomerLoading());
  //   final Either<Failure, List<CustomerEntity>> result =
  //   await getCustomersUsecase();
  //   result.fold(
  //         (failure) => emit(CustomerError(failure.message)),
  //         (customers) {
  //       _allCustomers = customers;
  //       emit(CustomerLoaded(customers));
  //     },
  //   );
  // }

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
