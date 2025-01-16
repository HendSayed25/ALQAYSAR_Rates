import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error.dart';
import '../../domain/entities/customer.dart';
import '../../domain/usecases/customer/add_customer_usecase.dart';
import '../../domain/usecases/customer/get_customers_usecase.dart';
import '../states/customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final GetCustomersUsecase getCustomers;
  final AddCustomerUsecase addCustomer;

  CustomerCubit({
    required this.getCustomers,
    required this.addCustomer,
  }) : super(CustomerInitial());

  Future<void> fetchCustomers() async {
    emit(CustomerLoading());
    final Either<Failure, List<Customer>> result = await getCustomers();
    result.fold(
          (failure) => emit(CustomerError(failure.message)),
          (customers) => emit(CustomerLoaded(customers)),
    );
  }

  Future<void> addNewCustomer(Customer customer) async {
    emit(CustomerLoading());
    final Either<Failure, Unit> result = await addCustomer(customer);
    result.fold(
          (failure) => emit(CustomerError(failure.message)),
          (_) {
        emit(CustomerAddedSuccessfully());
        fetchCustomers();
      },
    );
  }
}