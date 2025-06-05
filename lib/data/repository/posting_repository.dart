import 'dart:convert';
import 'dart:developer';

import 'package:canary_template/data/models/request/admin/posting_jual_request_model.dart';
import 'package:canary_template/data/models/response/burung_semua_tersedia_model.dart';
import 'package:canary_template/data/models/response/get_all_burung_response_model.dart';
import 'package:canary_template/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class PostingRepository {
  final ServiceHttpClient _serviceHttpClient;
  PostingRepository(this._serviceHttpClient);

  Future<Either<String, BurungSemuaTersediabyIdModel>> addPostBurung(
    PostingJualRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "admin/posting-jual",
        requestModel.toMap(),
      );

      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final profileResponse = BurungSemuaTersediabyIdModel.fromJson(
          jsonResponse,
        );
        log("Add Burung Successful: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add Burung Failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? 'Add Burung Failed');
      }
    } catch (e) {
      log("Error in add burung : $e");
      return Left('An error occurred while adding the posting: $e');
    }
  }

  Future<Either<String, GetAllBurungModel>> getAllBurung() async {
    try {
      final response = await _serviceHttpClient.get("admin/burung-semua");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final GetAllBurung = GetAllBurungModel.fromMap(jsonResponse);
        return Right(GetAllBurung);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Get All Burung Failed');
      }
    } catch (e) {
      return Left('An error occurred while fetching all burung: $e');
    }
  }
}
