import 'package:dio/dio.dart';
import 'package:flutter_riderapp/Models/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riderapp/Screen/.env.dart';



class DirectionsRepository{
  static const String _baseUrl='https://maps.googleapis.com/maps/api/distancematrix/json';
  final Dio _dio;
  DirectionsRepository({required Dio dio}): _dio=dio;
  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,


  })
  async{
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {

        'origin':'${origin.latitude},${origin.longitude}',
        'destination':'${destination.latitude},${destination.longitude}',
        'key':googleAPIKey
      },

    );
    if(response.statusCode==200){
      return Directions.fromMap(response.data);
    }
    return null;
  }
}