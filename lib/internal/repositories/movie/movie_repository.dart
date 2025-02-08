import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviedb/constants.dart';
import 'package:moviedb/domain/models/movie_cast.dart';
import 'package:moviedb/domain/models/movie_detail.dart';
import 'package:moviedb/domain/models/movie_review.dart';
import 'package:moviedb/domain/models/rate_movie.dart';
import 'package:moviedb/domain/models/request_token.dart';
import 'package:moviedb/internal/shared_preferences_instance.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieRepository {
  late Dio dio;
  late SharedPreferences store;
  String apiKey = "";
  String accessToken = "";
  MovieRepository() {
    dio = Dio();
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );

    apiKey = AppLocal.secretModel.apiKey;
    accessToken = AppLocal.secretModel.accessToken;
    store = SharedPreferencesInstance.intstance;
  }

  Future<List<Movie>> getRateMovies() async {
    late dynamic data;
    dio.options.headers['accept'] = "application/json";
    try {
      data = await dio.get(
          'https://api.themoviedb.org/3/trending/movie/week?api_key=${apiKey}');
    } catch (e) {
      debugPrint('Error occurred: $e');
    }

    return List<Map<String, dynamic>>.from(data.data["results"])
        .map((response) => Movie.fromJson(response))
        .toList();
  }

  Future<List<Movie>> getNowPlaying() async {
    late dynamic data;
    try {
      data = await dio.get(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=${apiKey}');
    } catch (e) {
      debugPrint('Error occurred: $e');
    }

    return List<Map<String, dynamic>>.from(data.data["results"])
        .map((response) => Movie.fromJson(response))
        .toList();
  }

  Future<bool> getIsAuth() async {
    return store.getBool(SharedPreferencesKeys.isAuthKey) ?? false;
  }

  Future<List<Movie>> getPopular() async {
    late dynamic data;
    try {
      data = await dio
          .get('https://api.themoviedb.org/3/movie/popular?api_key=${apiKey}');
    } catch (e) {
      debugPrint('Error occurred: $e');
    }

    return List<Map<String, dynamic>>.from(data.data["results"])
        .map(Movie.fromJson)
        .toList();
  }

  Future<List<Movie>> getTopRated() async {
    late dynamic data;
    try {
      data = await dio.get(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=${apiKey}');
    } catch (e) {
      debugPrint('Error occurred: $e');
    }

    return List<Map<String, dynamic>>.from(data.data["results"])
        .map(Movie.fromJson)
        .toList();
  }

  Future<List<Movie>> getUpcoming() async {
    late dynamic data;
    try {
      data = await dio
          .get('https://api.themoviedb.org/3/movie/upcoming?api_key=${apiKey}');
    } catch (e) {
      debugPrint('Error occurred: $e'); // Added error handling
    }

    return List<Map<String, dynamic>>.from(data.data["results"])
        .map(Movie.fromJson)
        .toList();
  }

  Future<MovieDetail> getMovieDetail(int id) async {
    late dynamic data;
    try {
      data = await dio
          .get('https://api.themoviedb.org/3/movie/${id}?api_key=${apiKey}');
    } catch (e) {
      debugPrint('Error occurred: $e');
    }

    return MovieDetail.fromJson(data.data);
  }

  Future<RequestToken?> getRequestToken() async {
    late RequestToken requestToken;
    late DateTime expireTokenDateTime;
    bool isValidToken = true;
    Duration tokenDuration = Duration(minutes: 60);
    DateTime dateTimeNow = DateTime.now().toUtc();

    try {
      final jsonDataToken =
          (await store.getString(SharedPreferencesKeys.requestTokenKey));

      if (jsonDataToken != "") {
        requestToken = RequestToken.fromJson(jsonDecode(jsonDataToken!));
        DateTime dateTimeToken =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(requestToken.expiresAt);
        expireTokenDateTime = dateTimeToken.add(tokenDuration);
        isValidToken = isValidRequestToken(dateTimeNow, expireTokenDateTime);

        if (isValidToken) {
          return requestToken;
        }
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
    try {
      requestToken = await createNewRequestToken();
      return requestToken;
    } catch (e) {
      return null;
    }
  }

  bool isValidRequestToken(currentDateTime, expireDateTime) {
    return currentDateTime.isBefore(currentDateTime);
  }

  Future<void> setIsAuthStatus(bool isAuth) async {
    final store = await SharedPreferences.getInstance();
    await store.setBool(SharedPreferencesKeys.isAuthKey, isAuth);
  }

  Future<RequestToken> createNewRequestToken() async {
    late dynamic data;
    late RequestToken requestToken;
    try {
      data = await dio.get(
          'https://api.themoviedb.org/3/authentication/token/new?api_key=${apiKey}');
      dio.options.headers['Authorization'] = "Bearer ${accessToken}";
      await store.setString(
          SharedPreferencesKeys.requestTokenKey, jsonEncode(data.data));
      requestToken = RequestToken.fromJson(jsonDecode(
          (await store.getString(SharedPreferencesKeys.requestTokenKey)!)));
    } catch (e) {
      debugPrint('Error occurred: $e');
    }

    return requestToken;
  }

  Future<String> createSessionId(String requestToken) async {
    late dynamic data;
    try {
      data = await dio.post(
        'https://api.themoviedb.org/3/authentication/session/new?api_key=${apiKey}',
        data: {
          "request_token": requestToken,
        },
      );
    } catch (e) {
      debugPrint('Error occurred: $e');
    }

    return data.data['session_id'];
  }

  Future<List<Movie>?> getWatchListMovies() async {
    late dynamic data;
    try {
      final requestToken = RequestToken.fromJson(jsonDecode(
          (await store.getString(SharedPreferencesKeys.requestTokenKey)!)));
      ;
      var sessionId = store.getString(SharedPreferencesKeys.sessionIdKey);
      if (sessionId == null) {
        sessionId = await createSessionId(requestToken.requestToken);
        await store.setString(SharedPreferencesKeys.sessionIdKey, sessionId);
      }

      data = await dio.get(
          "https://api.themoviedb.org/3/account/makar123213/watchlist/movies?api_key=${apiKey}&session_id=${sessionId}");
    } catch (e) {
      return null;
    }

    return List<Map<String, dynamic>>.from(data.data["results"])
        .map((response) => Movie.fromJson(response))
        .toList();
  }

  Future<List<MovieReview>> getReviewsByMovieId(num movieId) async {
    late dynamic data;
    try {
      data = await dio.get(
          "https://api.themoviedb.org/3/movie/${movieId}/reviews?api_key=${apiKey}");
    } catch (e) {
      debugPrint('Error occurred: $e');
    }

    return List<Map<String, dynamic>>.from(data.data["results"])
        .map((response) => MovieReview.fromJson(response))
        .toList();
  }

  Future<List<MovieCast>> getCastByMovieId(num movieId) async {
    late dynamic data;
    try {
      data = await dio.get(
          "https://api.themoviedb.org/3/movie/${movieId}/credits?api_key=${apiKey}");
    } catch (e) {
      debugPrint('Error occurred: $e');
    }

    return List<Map<String, dynamic>>.from(data.data["cast"])
        .map(MovieCast.fromJson)
        .toList();
  }

  Future<List<Movie>> getSearchMovies(String searchQuery) async {
    late dynamic data;

    try {
      data = await dio.get(
          "https://api.themoviedb.org/3/search/movie?api_key=${apiKey}",
          queryParameters: {"query": searchQuery});
    } catch (e) {
      debugPrint('Error occurred: $e');
    }

    return List<Map<String, dynamic>>.from(data.data["results"])
        .map(Movie.fromJson)
        .toList();
  }

  Future<void> addMovieToWatchList(num movieId, isAddedToWatchList) async {
    late dynamic data;

    try {
      var sessionId = store.getString(SharedPreferencesKeys.sessionIdKey);
      if (sessionId == null) {
        final requestToken = await getRequestToken();
        sessionId = await createSessionId(requestToken!.requestToken);
      }

      data = await dio.post(
        "https://api.themoviedb.org/3/account/20268556/watchlist?api_key=${apiKey}&session_id=${sessionId}",
        data: {
          "media_type": "movie",
          "media_id": movieId,
          "watchlist": isAddedToWatchList ? false : true,
        },
      );

      if (isAddedToWatchList) {
        AppLocal.movieWatchList.remove(movieId);
      } else {
        AppLocal.movieWatchList.add(movieId.toInt());
      }

      if (data.data['success'] == true) {
        return;
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
  }
}
