import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';

class BreakingNewsItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String source;
  final String timeAgo;
  final VoidCallback onTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onBookmarkTap;
  final Widget? bookmarkIcon;


  const BreakingNewsItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.timeAgo,
    required this.onTap,
    this.onShareTap,
    this.onBookmarkTap,
    this.bookmarkIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.surfaceColor,
        ),
        child: Stack(
          children: [
            //image of the news
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 270,
                width: 300,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            //Gradient for the contener
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),

            //text and icons button
            Positioned(
              bottom: 5,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          source,
                          style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(timeAgo, style: const TextStyle(color: Colors.white70, fontSize: 12)),

                      const SizedBox(width: 12),

                      //share button
                      GestureDetector(
                        onTap: onShareTap,
                        child: const Icon(Icons.share_outlined, color: Colors.white70, size: 20),
                      ),

                      const SizedBox(width: 12),

                      //bookmark button
                      IconButton(
                        onPressed: onBookmarkTap,
                        icon: bookmarkIcon ?? const Icon(Icons.bookmark_border_rounded, size: 20, color: Colors.greenAccent),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}