import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginpWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<String> loginpWithEmailPassword(
      {required String email, required String password}) async {
    throw UnimplementedError();
  }

  @override
  Future<String> singUpWithEmailPassword(
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
      }else{
        print(responce.user!.id);
      }
      return responce.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
