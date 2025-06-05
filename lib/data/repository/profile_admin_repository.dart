import 'dart:convert';
import 'dart:developer';

import 'package:canary_template/data/models/request/admin/admin_profile_request.dart';
import 'package:canary_template/data/models/response/admin_profile_response_model.dart';
import 'package:canary_template/services/service_http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileAdminRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  ProfileAdminRepository(this._serviceHttpClient);

  Future<Either<String, AdminProfileResponseModel>> addProfile(
    AdminProfileRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        '/admin/profile',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final profileResponse = AdminProfileResponseModel.fromMap(jsonResponse);
        log("Add Admin Profile Success: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add Admin Profile Failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? 'Create profile failed');
      }
    } catch (e) {
      log("Error adding admin profile: $e");
      return Left('An error occurred while adding the profile : $e');
    }
  }

  Future<Either<String, AdminProfileResponseModel>> getProfile() async {
    try {
      final response = await _serviceHttpClient.get('/admin/profile');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = AdminProfileResponseModel.fromMap(jsonResponse);
        log("Get Admin Profile Success: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        log("Get Admin Profile Failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? 'Get profile failed');
      }
    } catch (e) {
      log("Error getting admin profile: $e");
      return Left('An error occurred while getting the profile : $e');
    }
  }
}
