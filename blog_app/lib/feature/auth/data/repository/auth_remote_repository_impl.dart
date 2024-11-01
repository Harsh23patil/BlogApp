import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, String>> loginWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.singUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
