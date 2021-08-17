import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import 'app_exceptions.dart';

class BaseClient
{
  //timeout for http request (max time until http done or error will be thrown)
  static const duration = Duration(seconds: 10);

  static Future<dynamic> get(String url) async {
      var response = await GetConnect().httpClient.get(url).timeout(duration);
      return _processResponse(response);
  }


  static Future<dynamic> post(String url, {dynamic payload,Map<String, String>? headers,}) async {
      var response = await GetConnect().httpClient.post(url,body: payload,headers: headers).timeout(duration);
      return _processResponse(response);
  }


  static dynamic _processResponse(Response response){
    switch(response.statusCode){
      case 200:
      case 201:
      case 204:
        return response.body;
      case 400:
        throw BadRequestException(response.body['message'] ?? 'Invalid parameters');
      case 404:
        throw NotFoundException(response.body['message'] ?? 'Url not founded');
      case 401:
      case 403:
      throw UnauthorizedException(response.body['message'] ?? 'Unauthorized request');
      case 500:
      default:
      throw FetchDataException(response.body['message'] ?? 'No internet connection');
    }
  }
}