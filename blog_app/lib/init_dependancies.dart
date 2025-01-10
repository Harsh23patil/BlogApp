import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/feature/auth/data/repository/auth_remote_repository_impl.dart';
import 'package:blog_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/feature/auth/domain/usecases/current_user.dart';
import 'package:blog_app/feature/auth/domain/usecases/user_login.dart';
import 'package:blog_app/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feature/blog/data/datasources/blog_remote_data_sources.dart';
import 'package:blog_app/feature/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/feature/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/feature/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/feature/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final servieceLoacator = GetIt.instance;

Future<void> initDependancies() async {
  _intiAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.url,
    anonKey: AppSecrets.anons,
  );

  servieceLoacator.registerLazySingleton(() => supabase.client);

  // core
  servieceLoacator.registerLazySingleton(() => AppUserCubit());
}

void _intiAuth() {
  // Database
  servieceLoacator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(servieceLoacator()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        servieceLoacator(),
      ),
    )
    // usecase
    ..registerFactory(
      () => UserSignUp(
        servieceLoacator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        servieceLoacator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(servieceLoacator()),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: servieceLoacator(),
        userLogin: servieceLoacator(),
        currentUser: servieceLoacator(),
        appUserCubit: servieceLoacator(),
      ),
    );
}

void _initBlog() {
  servieceLoacator
    ..registerFactory<BlogRemoteDataSources>(
      () => BlogRemoteDataSourcesImpl(
        servieceLoacator(),
      ),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        servieceLoacator(),
      ),
    )
    ..registerFactory(
      () => UploadBlog(
        servieceLoacator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        servieceLoacator(),
      ),
    )
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: servieceLoacator(),
        getAllBlogs: servieceLoacator(),
      ),
    );
}
