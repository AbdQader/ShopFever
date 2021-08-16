import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'app_exceptions.dart';

class BaseClient
{
  Future<dynamic> get(String url) async {
    try {
      var response = await GetConnect().httpClient.get(url).timeout(Duration(seconds: 20));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    } on TimeoutException {
      throw ApiNotRespondingException('Api not responding');
    } on UnauthorizedException {
      throw UnauthorizedException('Unauthorized request');
    } on NotFoundException {
      throw UnauthorizedException('Url not founded');
    } on BadRequestException {
      throw BadRequestException('Invalid parameters');
    }catch(error){
      Logger().e('Error => ${error}');
      throw ApiNotRespondingException('No Internet connection');
    }
  }


  Future<dynamic> post(String url, {dynamic payload,Map<String, String>? headers,}) async {
    try {//ss
      var response = await GetConnect().httpClient.post(url,body: payload,headers: headers).timeout(Duration(seconds: 20));
      Logger().e('Response => ${response.body}');
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    } on TimeoutException {
      throw ApiNotRespondingException('Api not responding');
    } on UnauthorizedException {
      throw UnauthorizedException('Unauthorized request');
    } on NotFoundException {
      throw NotFoundException('Url not founded');
    } on BadRequestException {
      throw BadRequestException('Invalid parameters');
    }catch(error){
      throw ApiNotRespondingException('No Internet connection');
    }
  }


  dynamic _processResponse(Response response){
    switch(response.statusCode){
      case 200:
      case 201:
      case 204:
        return response.body;
      case 400:
        throw BadRequestException();
      case 404:
        throw NotFoundException();
      case 401:
      case 403:
      throw UnauthorizedException();
      case 500:
      default:
      throw FetchDataException();
    }
  }
}