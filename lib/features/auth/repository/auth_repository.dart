import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shartflix/features/auth/model/login_parameter.dart';
import 'package:shartflix/features/auth/model/user_model.dart';
import 'package:shartflix/features/auth/model/register_paarameter.dart';

import 'package:shartflix/shared/utils/context/constants/url.dart';
import 'package:shartflix/shared/utils/exceptions/app_exceptions.dart';
import 'package:shartflix/shared/model/api_response.dart';
import 'package:shartflix/shared/network/dio_client.dart';
import 'package:shartflix/shared/utils/storage.dart';

class AuthRepository {
  final DioClient _client = DioClient();

  Future<UserModel> login(LoginParameter param) async {
    try {
      final response = await _client.dio.post(
        AppUrls.login,
        data: param.toJson(),
      );
      if (response.statusCode != 200) {
        throw ServerException('Giriş başarısız: ${response.statusMessage}');
      }
      final ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      final UserModel loginResponse = UserModel.fromJson(apiResponse.data);
      if (loginResponse.token.isEmpty) {
        throw Exception("Token alınamadı");
      }
      await StorageService.saveToken(loginResponse.token);
      await StorageService.saveUserData(jsonEncode(loginResponse));
      return loginResponse;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      } else if (e.response?.statusCode == 400) {
        throw UserAlreadyExistsException();
      } else {
        throw ServerException(e.message ?? 'Sunucu hatası');
      }
    } catch (e) {
      throw NetworkException('Ağ bağlantısı kurulamadı.');
    }
  }

  Future<UserModel> register(RegisterParameter param) async {
    try {
      final response = await _client.dio.post(
        AppUrls.register,
        data: param.toJson(),
      );

      final ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      final UserModel loginResponse = UserModel.fromJson(apiResponse.data);
      if (loginResponse.token.isEmpty) {
        throw Exception("Token alınamadı");
      }
      await StorageService.saveToken(loginResponse.token);
      await StorageService.saveUserData(jsonEncode(loginResponse));
      return loginResponse;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException(e.message ?? 'Sunucu hatası');
      }
    } catch (_) {
      throw NetworkException('Ağ bağlantısı kurulamadı.');
    }
  }

  Future<bool> isLoggedIn() async {
    return await StorageService.hasToken();
  }

  Future<void> logout() async {
    try {
      await StorageService.clearAll();
    } catch (e) {
      await StorageService.clearAll();
      throw Exception('Logout failed: $e');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final userData = await StorageService.getUserData();
      if (userData != null) {
        final userJson = jsonDecode(userData) as Map<String, dynamic>;
        return UserModel.fromJson(userJson);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> uploadProfileImage(File imageFile) async {
    try {
      final token = await StorageService.getToken();

      if (token == null) {
        throw Exception('Token bulunamadı');
      }

      final fileName = imageFile.path.split('/').last;
      final fileExtension = fileName.split('.').last.toLowerCase();

      MediaType mediaType;
      switch (fileExtension) {
        case 'jpg':
        case 'jpeg':
          mediaType = MediaType('image', 'jpeg');
          break;
        case 'png':
          mediaType = MediaType('image', 'png');
          break;
        case 'webp':
          mediaType = MediaType('image', 'webp');
          break;
        default:
          mediaType = MediaType('application', 'octet-stream');
      }

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: mediaType,
        ),
      });

      final response = await Dio().post(
        'https://caseapi.servicelabs.tech/user/upload_photo',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            // Content-Type manuel eklenmedi; Dio kendisi otomatik ayarlıyor.
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['imageUrl'] ??
            data['profileImageUrl'] ??
            data['url'] ??
            'Yükleme başarılı ama URL dönmedi.';
      } else {
        throw Exception('Fotoğraf yüklenemedi: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Fotoğraf yükleme hatası: ${e.response?.data['message'] ?? e.message}',
        );
      } else {
        throw Exception('Ağ hatası: ${e.message}');
      }
    } catch (e) {
      throw Exception('Beklenmeyen hata: $e');
    }
  }
}
