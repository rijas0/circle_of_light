import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class CircleAccessDatasource {
  final Dio dio;
  final FlutterAppAuth appAuth;

  CircleAccessDatasource(this.dio,this.appAuth);
}