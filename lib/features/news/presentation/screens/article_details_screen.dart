import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/theme/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import '../../../bookmarks/presentation/cubit/bookmark_cubit.dart';
import '../../data/models/article_model.dart';
import 'article_webview_screen.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final ArticleModel article;
  const ArticleDetailsScreen({
    super.key,
    required this.article
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: (){
                  Share.share(article.url!);
                },
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_border_outlined,color: Colors.greenAccent,),
                iconSize: 30,
                onPressed: (){
                  context.read<BookmarkCubit>().toggleBookmark(article);
                },
              ),
            ],
            flexibleSpace:FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: article.imageUrl ??'https://via.placeholder.com/600x400',
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                errorWidget: (context, url, error) => const Icon(Icons.broken_image_rounded, color: AppColors.textSecondaryColor),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          article.sourceName,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        article.publishedAt?.substring(0,10)??'',
                        style: const TextStyle(
                          color: AppColors.textSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.tital,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    article.description??'No description available for this article.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 50),
                  if(article.url!=null)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:(context)=>ArticleWebviewScreen(
                                  url: article.url!,
                                  sourceName: article.sourceName,
                                ),
                            ),
                          );
                        },
                        child: const Text(
                          'Read Full Article',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    ) ;
  }
}
