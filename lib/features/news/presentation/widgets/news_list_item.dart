import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';

class NewsListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String source;
  final String timeAgo;
  final VoidCallback onTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onBookmarkTap;
  final Widget? bookmarkIcon;

  const NewsListItem({
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
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor, width: 1),
          boxShadow: const [
            BoxShadow(
              color: AppColors.primaryColor,
              offset: Offset(1, 2),
              blurRadius: 3,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 110,
                width: 110,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: AppColors.primaryColor, strokeWidth: 2)),
                  errorWidget: (context, url, error) => Container(color: AppColors.backgroundColor, child: const Icon(Icons.broken_image, color: AppColors.textSecondaryColor)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                // <-- التعديل هنا: خليناها 110 بدل 80 عشان توازي الصورة والنص ياخد راحته
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            source,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(timeAgo, style: Theme.of(context).textTheme.labelSmall),

                        const SizedBox(width: 10),

                        //share button
                        GestureDetector(
                          onTap: onShareTap,
                          child: const Icon(Icons.share_outlined, size: 18, color: AppColors.textSecondaryColor),
                        ),

                        const SizedBox(width: 10),

                        //Book Mark
                        IconButton(
                          onPressed: onBookmarkTap,
                          icon: bookmarkIcon ?? const Icon(Icons.bookmark_border_rounded, size: 20, color: Colors.greenAccent),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}