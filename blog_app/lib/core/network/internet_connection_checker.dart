import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class InternetConnectionChecker{
  Future<bool> get isConnected;
}

class ConnectionCheckermpl implements InternetConnectionChecker{
  final InternetConnection internetConnection;
  ConnectionCheckermpl(this.internetConnection);
  
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected async => await internetConnection.hasInternetAccess;
  
}