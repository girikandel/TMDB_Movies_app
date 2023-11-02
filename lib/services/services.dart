import 'package:http/http.dart' as http;
import 'package:movieapp/constants/api_constant.dart';
import 'package:movieapp/models/movie_model.dart';

class Services {
  fetchTrendingMovies() async {
    final response =
        await http.get(Uri.parse(ApiConstants.trendingMoviesUrl()));
    if (response.statusCode == 200) {
      return moviesModelFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  fetchTopRatedMovies() async {
    final response =
        await http.get(Uri.parse(ApiConstants.topRatedMoviesUrl()));
    if (response.statusCode == 200) {
      return moviesModelFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  fetchUpcomingMovies() async {
    final response =
        await http.get(Uri.parse(ApiConstants.upcomingMoviesUrl()));
    if (response.statusCode == 200) {
      return moviesModelFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  fetchSearchMovies(String searchTxt) async {
    final response =
        await http.get(Uri.parse(ApiConstants.searchMoviesUrl(searchTxt)));
    if (response.statusCode == 200) {
      return moviesModelFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  fetchSimilarMovies(int movieId) async {
    final response =
        await http.get(Uri.parse(ApiConstants.similarMoviesUrl(movieId)));
    if (response.statusCode == 200) {
      return moviesModelFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
