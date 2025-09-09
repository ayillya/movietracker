import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = "https://68bd8c7a227c48698f84ca0a.mockapi.io/api/v1/movies";

  Future<List<Movie>> fetchMovies() async {
    final response = await _dio.get(baseUrl);
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => Movie.fromJson(json)).toList(); //to get list of movies so that we can get the indexes
  }

  Future<Movie> updateMovie(String id, Map<String, dynamic> data) async {
    final response = await _dio.put("$baseUrl/$id", data: data);
    return Movie.fromJson(response.data);
  }

  Future<void> deleteMovie(String id) async {
    await _dio.delete("$baseUrl/$id");
  }
}
