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
      newsList.assignAll(articles);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch news");
    } finally {
      isLoading.value = false;
    }
  }
}
