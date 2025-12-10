import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsView extends StatelessWidget {
  final Map<String, dynamic> article;

  const NewsDetailsView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;

    final imageUrl = article['urlToImage'];
    final source = article['source']?['name'] ?? "News Source";
    final title = article['title'] ?? "";
    final description = article['description'] ?? "";
    final articleUrl = article['url'];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1A73E8),
        centerTitle: true,
        title: Text(
          source,
          style: TextStyle(
            fontSize: isSmall ? 16 : 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // IMAGE WITH MODERN GRADIENT
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/no_image.png",
                    image: imageUrl ?? "",
                    height: size.height * 0.28,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // WARM TOP GRADIENT (premium look)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: size.height * 0.10,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.02),

            // CONTENT CARD (Glass + Depth)
            Container(
              margin: EdgeInsets.all(size.width * 0.04),
              padding: EdgeInsets.all(size.width * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Modern Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isSmall ? 18 : 24,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: size.height * 0.015),

                  // Description text
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: isSmall ? 14 : 16,
                      height: 1.55,
                      color: Colors.grey.shade800,
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  // BUTTON: Read full article
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A73E8),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.12,
                          vertical: size.height * 0.017,
                        ),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () async {
                        if (articleUrl == null) return;
                        final uri = Uri.parse(articleUrl);
                        if (await canLaunchUrl(uri)) {
                          launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.open_in_new, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "Read Full Article",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
