import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entity/user.dart';
import 'package:blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class CurrentUser implements UseCase<User,NoParams >{
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    // TODO: implement call
    return authRepository.currentUser();
  }

}

