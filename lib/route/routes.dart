import 'package:get/get.dart';
import 'package:movieapp/route/route_constant.dart';
import 'package:movieapp/screens/home/pages/home_page.dart';

import '../screens/home/pages/movie_detail_page.dart';

class MeroRoutes {
  static final routes = [
    GetPage(name: MeroRouteNames.homePage, page: () => const HomePage()),
    GetPage(
        name: MeroRouteNames.movieDetailPage,
        page: () => const MovieDetailPage()),
  ];
}
