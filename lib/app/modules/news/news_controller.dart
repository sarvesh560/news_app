import 'package:get/get.dart';
import '../../data/services/news_service.dart';

class NewsController extends GetxController {
  final NewsService _service = NewsService();

  RxBool isLoading = false.obs;
  RxList newsList = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadNews();
  }

  Future<void> loadNews() async {
    try {
      isLoading.value = true;

      final articles = await _service.fetchNews();

      print("ARTICLES LOADED: ${articles.length}");
      print("FIRST ARTICLE: ${articles.isNotEmpty ? articles[0] : 'NONE'}");

      newsList.assignAll(articles);
    } catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      isLoading.value = false;
    }
  }
}
