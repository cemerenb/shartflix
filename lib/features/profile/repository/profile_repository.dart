import 'package:dio/dio.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/shared/network/dio_client.dart';
import 'package:shartflix/shared/utils/constants/url.dart';
import 'package:shartflix/shared/utils/exceptions/app_exceptions.dart';
import 'package:shartflix/shared/utils/storage.dart';

class ProfileRepository {
  final DioClient _client = DioClient();
  Future<List<Movie>> getFavorites() async {
    try {
      final token = await StorageService.getToken();

      final response = await _client.dio.get(
        AppUrls.getFavorites,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode != 200) {
        throw ServerException('Favori işlenemedi ${response.statusMessage}');
      } else {
        if (response.data['data'].isEmpty) {
          return [];
        }
        final List<Movie> favoriteList = (response.data['data'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
        if (favoriteList.isNotEmpty) {
          return favoriteList;
        } else {
          throw ServerException('Favori işlenemedi ${response.statusMessage}');
        }
      }
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
}
