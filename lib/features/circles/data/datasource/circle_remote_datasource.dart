import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class CircleRemoteDataSource {
  final Dio dio;
  final FlutterAppAuth appAuth;
  CircleRemoteDataSource(this.dio,this.appAuth);

  
}