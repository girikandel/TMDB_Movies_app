import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/services/services.dart';
import 'package:movieapp/utils/popup_provider.dart';

class HomePageController extends GetxController {
  static HomePageController instance = Get.find();

  Rx<MoviesModel> trendingMovies = MoviesModel().obs;
  Rx<MoviesModel> topRatedMovies = MoviesModel().obs;
  Rx<MoviesModel> upcomingMovies = MoviesModel().obs;
  Rx<MoviesModel> searchedMovies = MoviesModel().obs;
  Rx<MoviesModel> similarMovies = MoviesModel().obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;

  RxBool isTrendingLoading = false.obs;
  RxBool isTopRatedLoading = false.obs;
  RxBool isUpcomingLoading = false.obs;
  RxBool isSearchLoading = false.obs;
  RxBool isSimilarLoading = false.obs;

  getTrendingMovies() async {
    isTrendingLoading.value = true;
    try {
      trendingMovies.value = await Services().fetchTrendingMovies();
    } catch (e) {
      PopupProvider.showFlutterToast(
        msg: "Something went wrong!",
        color: Colors.red,
      );
      log("message: $e");
    } finally {
      isTrendingLoading.value = false;
    }
  }

  getTopRatedMovies() async {
    isTopRatedLoading.value = true;
    try {
      topRatedMovies.value = await Services().fetchTopRatedMovies();
      log("This is top rated movies: ${topRatedMovies.value.results?.length}");
    } catch (e) {
      PopupProvider.showFlutterToast(
        msg: "Something went wrong!",
        color: Colors.red,
      );
      log("message: $e");
    } finally {
      isTopRatedLoading.value = false;
    }
  }

  getUpcomingMovies() async {
    isUpcomingLoading.value = true;
    try {
      upcomingMovies.value = await Services().fetchUpcomingMovies();
    } catch (e) {
      PopupProvider.showFlutterToast(
        msg: "Something went wrong!",
        color: Colors.red,
      );
      log("message: $e");
    } finally {
      isUpcomingLoading.value = false;
    }
  }

  getSearchMovies() async {
    isSearchLoading.value = true;
    try {
      searchedMovies.value =
          await Services().fetchSearchMovies(searchController.value.text);
    } catch (e) {
      PopupProvider.showFlutterToast(
        msg: "Something went wrong!",
        color: Colors.red,
      );
      log("message: $e");
    } finally {
      isSearchLoading.value = false;
    }
  }

  getSimilarMovies(int movieId) async {
    isSimilarLoading.value = true;
    try {
      similarMovies.value = await Services().fetchSimilarMovies(movieId);
      log("This is similar movies length: ${similarMovies.value.results?.length}");
    } catch (e) {
      PopupProvider.showFlutterToast(
        msg: "Something went wrong!",
        color: Colors.red,
      );
      log("message: $e");
    } finally {
      isSimilarLoading.value = false;
    }
  }
}
