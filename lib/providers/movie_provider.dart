import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';
import '../models/movie_model.dart';
import '../apistate_enums.dart';


class MovieProvider with ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Movie> movies = [];
  ApiState state = ApiState.initial;
  String? errorMessage;

  MovieProvider() {
    fetchMovies(); // auto-fetch when initialized
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timed out. Please retry.";
      case DioExceptionType.sendTimeout:
        return "Request timed out while sending.";
      case DioExceptionType.receiveTimeout:
        return "Server took too long to respond.";
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        return "Server error: $statusCode";
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "No internet connection. Please check your network.";
      case DioExceptionType.unknown:
      default:
        return "Unexpected error: ${e.message}";
    }
  }

  int findMovieIndexById(List<Movie> movies, String id) {
    for (int i = 0; i < movies.length; i++) {
      if (movies[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  Future<void> fetchMovies() async {
    state = ApiState.loading;
    notifyListeners();
    try {
      movies = await apiService.fetchMovies();
      state = ApiState.success;
      errorMessage = null;
    } on DioException catch (e) {
      state = ApiState.error;
      errorMessage = _handleDioError(e);
    } catch (_) {
      state = ApiState.error;
      errorMessage = "Something went wrong.";
    }
    notifyListeners();
  }

  Future<void> updateRating(String id, double rating) async {
    state = ApiState.loading;
    notifyListeners();
    try {
      final updatedMovie = await apiService.updateMovie(id, {"rating": rating});
      final index = findMovieIndexById(movies, id);
      if (index != -1) movies[index] = updatedMovie;
      state = ApiState.success;
    } on DioException catch (e) {
      state = ApiState.error;
      errorMessage = _handleDioError(e);
    } catch (_) {
      state = ApiState.error;
      errorMessage = "Something went wrong.";
    }
    notifyListeners();
  }

  Future<void> deleteMovie(String id) async {
    state = ApiState.loading;
    notifyListeners();
    try {
      await apiService.deleteMovie(id);
      final index = findMovieIndexById(movies, id);
      if (index != -1) {
        movies.removeAt(index);
      }
      state = ApiState.success;
    } on DioException catch (e) {
      state = ApiState.error;
      errorMessage = _handleDioError(e);
    } catch (_) {
      state = ApiState.error;
      errorMessage = "Something went wrong.";
    }
    notifyListeners();
  }
}
