import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/constants/controllers.dart';
import 'package:movieapp/constants/padding_constants.dart';
import 'package:movieapp/utils/extensions.dart';

import '../../../models/movie_model.dart';
import '../controller/home_page_controller.dart';
import '../widgets/movie_slider.dart';
import '../widgets/trending_movie_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<MoviesModel>> trendingMovies;

  @override
  void initState() {
    Get.put(HomePageController());
    callApi();
    super.initState();
  }

  callApi() async {
    await homePageCtrl.getTrendingMovies();
    await homePageCtrl.getTopRatedMovies();
    await homePageCtrl.getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Movie App'),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        onRefresh: () async {
          callApi();
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _searchWidget(context),
                SizedBox(height: 0.015.h(context)),
                Obx(
                  () => Visibility(
                    visible: (homePageCtrl.searchedMovies.value.results ?? [])
                        .isNotEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: horizontalPadding(context),
                          child: Text(
                            'Searched Movies',
                            style: TextStyle(
                              fontSize: 0.015.toResponsive(context),
                            ),
                          ),
                        ),
                        SizedBox(height: 0.015.h(context)),
                        MoviesSlider(
                          movies: homePageCtrl.searchedMovies.value,
                          isLoading: homePageCtrl.isSearchLoading.value,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0.01.h(context)),
                Padding(
                  padding: horizontalPadding(context),
                  child: Text(
                    "Trending Movies",
                    style: TextStyle(
                      fontSize: 0.015.toResponsive(context),
                    ),
                  ),
                ),
                const TrendingMoviesSlider(),
                SizedBox(height: 0.015.h(context)),
                Padding(
                  padding: horizontalPadding(context),
                  child: Text(
                    'Top Rated Movies',
                    style: TextStyle(
                      fontSize: 0.015.toResponsive(context),
                    ),
                  ),
                ),
                SizedBox(height: 0.01.h(context)),
                Obx(
                  () => MoviesSlider(
                    movies: homePageCtrl.topRatedMovies.value,
                    isLoading: homePageCtrl.isTopRatedLoading.value,
                  ),
                ),
                SizedBox(height: 0.015.toResponsive(context)),
                Padding(
                  padding: horizontalPadding(context),
                  child: Text(
                    'Upcoming Movies',
                    style: TextStyle(
                      fontSize: 0.015.toResponsive(context),
                    ),
                  ),
                ),
                SizedBox(height: 0.01.toResponsive(context)),
                Obx(
                  () => MoviesSlider(
                    movies: homePageCtrl.upcomingMovies.value,
                    isLoading: homePageCtrl.isUpcomingLoading.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _searchWidget(BuildContext context) {
    return Container(
      height: 0.06.h(context),
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 0.01.h(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: Center(
        child: Form(
          key: homePageCtrl.formKey.value,
          child: TextFormField(
            controller: homePageCtrl.searchController.value,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              if (homePageCtrl.formKey.value.currentState!.validate()) {
                homePageCtrl.getSearchMovies();
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search Movies',
              hintStyle: TextStyle(
                color: Colors.grey.withOpacity(0.5),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  homePageCtrl.searchController.value.clear();
                  FocusScope.of(context).unfocus();
                  homePageCtrl.searchedMovies.value.results!.clear();
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
