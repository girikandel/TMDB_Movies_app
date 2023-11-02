import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/constants/colors.dart';
import 'package:movieapp/constants/controllers.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/api_constant.dart';
import '../../../route/route_constant.dart';

class MoviesSlider extends StatelessWidget {
  final MoviesModel? movies;
  final bool isLoading;
  const MoviesSlider({
    super.key,
    required this.movies,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? _loadingShimmer(context)
        : SizedBox(
            height: 0.26.h(context),
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies?.results?.length ?? 0,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Get.toNamed(MeroRouteNames.movieDetailPage,
                      arguments: movies?.results?[index]),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 0.015.h(context), right: 0.015.h(context)),
                    height: 0.26.h(context),
                    width: 0.19.h(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${ApiConstants.imageUrl}${movies?.results?[index].posterPath}',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }

  _loadingShimmer(BuildContext context) {
    return SizedBox(
      height: 0.26.h(context),
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 0.26.h(context),
            width: 0.19.h(context),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.35),
              highlightColor: Colors.grey.withOpacity(0.6),
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 0.26.h(context),
                width: 0.19.h(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
