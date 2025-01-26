import 'package:alqaysar_rates/features/domain/usecases/customer/add_customer_rate_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/local/app_prefs.dart';
import 'features/data/remote_data_source/auth_remote_data_source.dart';
import 'features/data/remote_data_source/customer_remote_data_source.dart';
import 'features/data/repository/auth_repository.dart';
import 'features/data/repository/customer_repository.dart';
import 'features/domain/repository/auth_repository.dart';
import 'features/domain/repository/customer_repository.dart';
import 'features/domain/usecases/auth/login_usecase.dart';
import 'features/domain/usecases/auth/logout_usecase.dart';
import 'features/domain/usecases/customer/add_customer_usecase.dart';
import 'features/domain/usecases/customer/delete_customer_usecase.dart';
import 'features/domain/usecases/customer/get_customers_usecase.dart';
import 'features/domain/usecases/customer/update_customer_name_usecase.dart';
import 'features/ui/cubit/customer_cubit.dart';
import 'features/ui/cubit/login_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  /// Initialize Shared Preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<AppPrefs>(() => AppPrefsImpl(sharedPreferences));

  /// notifications
  // NotificationService notificationService = NotificationService(SupabaseClientProvider.client);
  // notificationService.initNotifications();
  // sl.registerLazySingleton(() => notificationService);

  /// one signal
  // sl.registerLazySingleton(() => OneSignalService());

  /// Data Layer
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<CustomerRemoteDataSource>(() => CustomerRemoteDataSourceImpl());

  /// Domain Layer
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(sl()));


  /// Use Cases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => GetCustomersUsecase(sl()));
  sl.registerLazySingleton(() => AddCustomerUsecase(sl()));
  sl.registerLazySingleton(() => AddCustomerRateUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCustomerNameUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCustomerUsecase(sl()));

  /// Presentation Layer
  sl.registerFactory(() => AuthCubit(login: sl()));
  sl.registerFactory(() => CustomerCubit(getCustomersUsecase: sl(),addCustomerUsecase: sl(), deleteCustomerUsecase: sl(), updateCustomerNameUsecase: sl(), addCustomerRateUsecase: sl()));
}
