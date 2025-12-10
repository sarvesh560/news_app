import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'news_controller.dart';
import 'news_detail_view.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 350;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1A73E8),
                Color(0xFF4FC3F7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          "Top News",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: isSmall ? 18 : 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.loadNews,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.01,
            ),
            itemCount: controller.newsList.length,
            itemBuilder: (context, index) {
              final article = controller.newsList[index];

              return GestureDetector(
                onTap: () => Get.to(() => NewsDetailsView(article: article)),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/no_image.png",
                          image: article['urlToImage'] ?? "",
                          height: size.height * 0.25,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Modern Chip
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCEEFF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                article['source']?['name'] ?? "News",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A73E8),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              article['title'] ?? "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: isSmall ? 15 : 19,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              article['description'] ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: isSmall ? 12 : 14,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
