class ApiConstants {
  const ApiConstants._();

  static const String apiKey = "c732aaf33e4ebcd1ee6c9d06c6ea3f5f";
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String imageUrl = "https://image.tmdb.org/t/p/w500/";

  static trendingMoviesUrl() {
    return "$baseUrl/trending/movie/day?api_key=$apiKey";
  }

  static topRatedMoviesUrl() {
    return "$baseUrl/movie/top_rated?api_key=$apiKey";
  }

  static upcomingMoviesUrl() {
    return "$baseUrl/movie/upcoming?api_key=$apiKey";
  }

  static searchMoviesUrl(String search) {
    return "$baseUrl/search/movie?query=$search&api_key=$apiKey";
  }

  static similarMoviesUrl(int movieId) {
    return "$baseUrl/movie/$movieId?api_key=$apiKey";
  }
}
