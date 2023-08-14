import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Data{
  String urlBase = "http://api.weatherapi.com/v1/";
  String urlAction = "current.json?";
  String apiKey = "key=b69cf1d7c3074dd6a13133449231108";
  String q = "pontianak";

  Future<Map<dynamic,dynamic>> getComing() async{
    String url = "$urlBase$urlAction$apiKey&q=$q&aqi=yes";
    Response result = await get(Uri.parse(url));

    if(result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      return jsonResponse;
    }else{
      return {};
    }
    
  }

  Future<void> searchCities(String input) async{
    urlAction = "search.json?";
    q = input;
    String url = "$urlBase$urlAction$apiKey&q=$q";
    Response result = await get(Uri.parse(url));

    if(result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      String cityName = jsonResponse[0]['name'].toString();
      q = cityName;
    }
    urlAction = "current.json?";
    // return await getComing();
  }

  // Stream<void> refreshData() async*{
  //   yield* Stream.periodic(const Duration(minutes: 1), (int a) async{
  //   String url = "$urlBase$urlAction$apiKey&q=$q&aqi=yes";
  //   Response result = await get(Uri.parse(url));
  //   if(result.statusCode == HttpStatus.ok){
  //     final jsonResponse = json.decode(result.body);
      
  //   }else{

  //   }
  //   });
  // }

}