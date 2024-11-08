import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/feature/auth/data/repository/auth_remote_repository_impl.dart';
import 'package:blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/feature/auth/domain/usecases/user_login.dart';
import 'package:blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final servieceLoacator = GetIt.instance;

Future<void> initDependancies() async {
  _intiAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.url,
    anonKey: AppSecrets.anons,
  );

  servieceLoacator.registerLazySingleton(() => supabase.client);
}

void _intiAuth() {
  servieceLoacator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(servieceLoacator()),
  );

  servieceLoacator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      servieceLoacator(),
    ),
  );

  servieceLoacator.registerFactory(
    () => UserSignUp(
      servieceLoacator(),
    ),
  );

  servieceLoacator.registerFactory(
    () => UserLogin(
      servieceLoacator(),
    ),
  );

  servieceLoacator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: servieceLoacator(),
      userLogin: servieceLoacator()
    ),
  );

}
