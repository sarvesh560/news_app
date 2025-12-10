import 'package:get/get.dart';
import '../modules/news/news_binding.dart';
import '../modules/news/news_view.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: '/news',
      page: () => const NewsView(),
      binding: NewsBinding(),
    ),
  ];
}
