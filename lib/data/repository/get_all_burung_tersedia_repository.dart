import 'dart:convert';
import 'dart:io';

import 'package:canary_template/data/models/response/burung_semua_tersedia_model.dart';
import 'package:canary_template/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class GetAllBurungTersediaRepository {
  final ServiceHttpClient httpClient;
  GetAllBurungTersediaRepository(this.httpClient);

  Future<Either<String, BurungSemuaTersediaModel>>
  getAllBurungTersedia() async {
    try {
      final response = await httpClient.get("buyer/burung-semua-tersedia");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final burungTersediaResponse = BurungSemuaTersediaModel.fromJson(
          jsonResponse,
        );
        return Right(burungTersediaResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      if (e is SocketException) {
        return Left('Network error: Please check your internet connection.');
      } else if (e is HttpException) {
        return Left('HTTP error: ${e.message}');
      } else if (e is FormatException) {
        return Left('invalid response format');
      } else {
        return Left('An unexpected error occurred: $e');
      }
    }
  }
}
