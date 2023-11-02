import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/constants/api_constant.dart';
import 'package:movieapp/constants/controllers.dart';
import 'package:movieapp/constants/padding_constants.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/screens/home/widgets/movie_slider.dart';
import 'package:movieapp/utils/extensions.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Result movie;

  @override
  void initState() {
    movie = Get.arguments;
    callApi();

    super.initState();
  }

  callApi() async {
    await homePageCtrl.getSimilarMovies(movie.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              leading: Container(
                margin: const EdgeInsets.all(7.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              expandedHeight: 0.6.h(context),
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  movie.title ?? "",
                  style: TextStyle(
                    fontSize: 0.015.toResponsive(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    "${ApiConstants.imageUrl}${movie.posterPath}",
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: bodyOnlyPadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overview",
                      style: TextStyle(
                        fontSize: 0.017.toResponsive(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.01.h(context)),
                    Text(
                      movie.overview ?? '',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 0.014.toResponsive(context),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 0.01.h(context)),
                    movieInfoContainer(
                      text:
                          'Release Date: ${movie.releaseDate.toString().split(' ')[0]}',
                    ),
                    SizedBox(height: 0.01.h(context)),
                    movieInfoContainer(
                      text:
                          'Original Language: ${getLanguage(movie.originalLanguage ?? OriginalLanguage.EN)}',
                    ),
                    SizedBox(height: 0.01.h(context)),
                    movieInfoContainer(
                      text: 'Popularity: ${movie.popularity}',
                    ),
                    SizedBox(height: 0.01.h(context)),
                    movieInfoContainer(
                      text: 'Rating: ${movie.voteAverage}/10',
                    ),
                    SizedBox(height: 0.01.h(context)),
                    Obx(
                      () => Visibility(
                        visible:
                            homePageCtrl.similarMovies.value.results != null &&
                                homePageCtrl
                                    .similarMovies.value.results!.isNotEmpty,
                        child: Column(
                          children: [
                            SizedBox(height: 0.03.h(context)),
                            Text(
                              "Similar Movies",
                              style: TextStyle(
                                fontSize: 0.015.toResponsive(context),
                              ),
                            ),
                            SizedBox(height: 0.02.h(context)),
                            MoviesSlider(
                              movies: homePageCtrl.similarMovies.value,
                              isLoading: homePageCtrl.isSimilarLoading.value,
                            ),
                            SizedBox(height: 0.03.h(context)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  movieInfoContainer({required String text}) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }

  getLanguage(OriginalLanguage originalLanguage) {
    if (originalLanguage == OriginalLanguage.EN) {
      return "English";
    } else if (originalLanguage == OriginalLanguage.ES) {
      return "Spanish";
    } else if (originalLanguage == OriginalLanguage.PT) {
      return "Portuguese";
    } else {
      return "Unknown";
    }
  }
}
