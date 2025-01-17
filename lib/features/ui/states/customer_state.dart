import 'package:equatable/equatable.dart';

import '../../domain/entities/customer.dart';

abstract class CustomerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final List<Customer> customers;

  CustomerLoaded(this.customers);

  @override
  List<Object?> get props => [customers];
}

class CustomerAddedSuccessfully extends CustomerState {}

class CustomerDeletedSuccessfully extends CustomerState {}

class CustomerUpdatedSuccessfully extends CustomerState {}

class CustomerError extends CustomerState {
  final String message;

  CustomerError(this.message);

  @override
  List<Object?> get props => [message];
}