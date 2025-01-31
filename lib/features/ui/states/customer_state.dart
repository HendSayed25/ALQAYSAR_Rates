import 'package:equatable/equatable.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/rate_entity.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object?> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerError extends CustomerState {
  final String message;

  const CustomerError(this.message);

  @override
  List<Object?> get props => [message];
}

class CustomerLoaded extends CustomerState {
  final List<CustomerEntity> customers;

  const CustomerLoaded(this.customers);

  @override
  List<Object?> get props => [customers];
}
class CustomerRateLoaded extends CustomerState {
  final List<RateEntity> rates;

  const CustomerRateLoaded(this.rates);

  @override
  List<Object?> get props => [rates];
}


class CustomerAddedSuccessfully extends CustomerState {}

class CustomerEditedSuccessfully extends CustomerState {}

class CustomerDeletedSuccessfully extends CustomerState {}

class CustomerNameUpdatedSuccessfully extends CustomerState {}

class CustomerRateUpdatedSuccessfully extends CustomerState {}

// class CustomerByIdLoaded extends CustomerState {
//   final CustomerEntity customer;
//
//   const CustomerByIdLoaded(this.customer);
//
//   @override
//   List<Object?> get props => [customer];
// }
//

class RatingCategorySelected extends CustomerState {
  final String category;

  const RatingCategorySelected(this.category);

  @override
  List<Object?> get props => [category];
}

class RatingPhoneNumberUpdated extends CustomerState {
  final PhoneNumber phoneNumber;

  const RatingPhoneNumberUpdated(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}
