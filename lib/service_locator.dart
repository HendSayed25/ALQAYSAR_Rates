import 'package:get_it/get_it.dart';

import 'features/data/supabase_client.dart';
import 'features/data/repository/user_repository.dart';
import 'features/data/data_source/remote_data_source.dart';
import 'features/domain/repository/user_repository.dart';
import 'features/domain/usecases/login_usecase.dart';
import 'features/presentation/cubit/login_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  /// Initialize Supabase
  await SupabaseClientProvider.initialize();

  /// Data Layer
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource());
  sl.registerLazySingleton<UserRepositoryInterface>(() => UserRepositoryImpl(sl()));

  /// Domain Layer
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

  /// Presentation Layer
  sl.registerFactory(() => LoginCubit(sl<LoginUseCase>()));
}