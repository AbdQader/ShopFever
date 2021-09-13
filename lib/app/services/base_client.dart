import 'dart:async';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';
import 'app_exceptions.dart';

class BaseClient
{
  //timeout for http request (max time until http done or error will be thrown)
  static const duration = Duration(seconds: 10);

  ///safe get api request
  static Future<dynamic> get(String url, {Map<String,dynamic>? query,Map<String, String>? headers}) async {
      var response = await GetConnect().httpClient.get(url, headers: headers,query: query).timeout(duration);
      return _processResponse(response);
  }

  ///safe post api request
  static Future<dynamic> post(String url, {dynamic body,Map<String, String>? headers,Map<String,dynamic>? query}) async {
      var response = await GetConnect().httpClient.post(url,body: body,headers: headers,query: query).timeout(duration);
      Logger().e(response.body);
      return _processResponse(response);
  }

  ///safe delete api request
  static Future<dynamic> delete(String url, {Map<String,dynamic>? query,Map<String, String>? headers}) async {
    var response = await GetConnect().httpClient.delete(url, headers: headers,query: query).timeout(duration);
    return _processResponse(response);
  }

  //safe patch request
  static Future<dynamic> patch(String url, {dynamic body,Map<String, String>? headers,Map<String,dynamic>? query}) async {
    var response = await GetConnect().httpClient.patch(url,body: body,headers: headers,query: query).timeout(duration);
    return _processResponse(response);
  }

  ///check if the response is valid (everything went fine) / else throw error
  static dynamic _processResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
          if(HelperFunctions.checkIfStatusSuccess(response.body))
            return response.body;
          else
            throw BadRequestException(response.body['message'] ?? 'Invalid api call');
      case 400:
        throw BadRequestException(response.body['message'] ?? 'Invalid api call');
      case 404:
        throw NotFoundException('Url not founded');
      case 401:
      case 403:
      throw UnauthorizedException(response.body['message'] ?? 'Unauthorized request');
      case 500:
      default:
      throw FetchDataException('No internet connection');
    }
  }

}