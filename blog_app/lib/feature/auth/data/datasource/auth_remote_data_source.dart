import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/feature/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginpWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> loginpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final responce = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (responce.user == null) {
        throw const ServerException("User is null");
      } else {
        print(responce.user!.id);
      }
      return UserModel.fromJson(responce.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> singUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    // TODO: implement singUpWithEmailPassword
    try {
      final responce = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {"name": name},
      );
      if (responce.user == null) {
        throw const ServerException("User is null");
      } else {
        print(responce.user!.id);
      }
      return UserModel.fromJson(responce.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
