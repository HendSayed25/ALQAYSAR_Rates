import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error.dart';
import '../../domain/entities/customer.dart';
import '../../domain/usecases/customer/add_customer_usecase.dart';
import '../../domain/usecases/customer/delete_customer_usecase.dart';
import '../../domain/usecases/customer/get_customers_usecase.dart';
import '../../domain/usecases/customer/update_customer_usecase.dart';
import '../states/customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final GetCustomersUsecase getCustomersUsecase;
  final AddCustomerUsecase addCustomerUsecase;
  final DeleteCustomerUsecase deleteCustomerUsecase;
  final UpdateCustomerUsecase updateCustomerUsecase;
  List<Customer> _allCustomers = [];

  CustomerCubit({
    required this.deleteCustomerUsecase,
    required this.updateCustomerUsecase,
    required this.getCustomersUsecase,
    required this.addCustomerUsecase,
  }) : super(CustomerInitial());

  Future<void> fetchCustomers() async {
    emit(CustomerLoading());
    final Either<Failure, List<Customer>> result = await getCustomersUsecase();
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (customers) {
        _allCustomers = customers;
        emit(CustomerLoaded(customers));
      },
    );
  }

  Future<void> addNewCustomer(Customer customer) async {
    emit(CustomerLoading());
    final Either<Failure, Unit> result = await addCustomerUsecase(customer);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (_) {
        emit(CustomerAddedSuccessfully());
        fetchCustomers();
      },
    );
  }

  Future<void> deleteCustomer(int customerId) async {
    emit(CustomerLoading());
    final Either<Failure, Unit> result = await deleteCustomerUsecase(customerId);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (_) {
        emit(CustomerDeletedSuccessfully());
        fetchCustomers();
      },
    );
  }

  Future<void> updateCustomer(Customer customer) async {
    emit(CustomerLoading());
    final Either<Failure, Unit> result = await updateCustomerUsecase(customer);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (_) {
        emit(CustomerUpdatedSuccessfully());
        fetchCustomers();
      },
    );
  }

  void filterCustomers(String query) {
    if (query.isEmpty) {
      emit(CustomerLoaded(_allCustomers));
    } else {
      final filteredCustomers = _allCustomers
          .where((customer) =>
              customer.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(CustomerLoaded(filteredCustomers));
    }
  }
}
