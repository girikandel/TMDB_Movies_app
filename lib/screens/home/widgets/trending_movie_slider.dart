import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/constants/api_constant.dart';
import 'package:movieapp/constants/controllers.dart';
import 'package:movieapp/route/route_constant.dart';
import 'package:movieapp/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

class TrendingMoviesSlider extends StatelessWidget {
  const TrendingMoviesSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homePageCtrl.isTrendingLoading.isTrue
          ? _shimmerCarousel(context)
          : SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount:
                    (homePageCtrl.trendingMovies.value.results ?? []).length,
                options: CarouselOptions(
                  height: 0.37.h(context),
                  autoPlay: true,
                  viewportFraction: 0.55,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                ),
                itemBuilder: (context, index, pageViewIndex) {
                  final currentMovie =
                      homePageCtrl.trendingMovies.value.results?[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(MeroRouteNames.movieDetailPage,
                        arguments: currentMovie),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 0.37.h(context),
                      width: 0.27.h(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          '${ApiConstants.imageUrl}${currentMovie?.posterPath}',
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  _shimmerCarousel(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 3,
        options: CarouselOptions(
          height: 0.37.h(context),
          autoPlay: false,
          viewportFraction: 0.55,
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
        itemBuilder: (context, index, pageViewIndex) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.35),
            highlightColor: Colors.grey.withOpacity(0.6),
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 0.37.h(context),
              width: 0.27.h(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
