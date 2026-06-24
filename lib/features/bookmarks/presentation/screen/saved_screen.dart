import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/features/bookmarks/presentation/cubit/bookmark_cubit.dart';
import 'package:newsly/features/news/presentation/widgets/news_list_item.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../news/presentation/screens/article_details_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
        centerTitle: true,
      ),
      body: BlocBuilder<BookmarkCubit, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkLoaded) {
            final savedArticles = state.savedArticles;

            if (savedArticles.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No saved articles yet.',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              itemCount: savedArticles.length,
              itemBuilder: (context, index) {
                final article = savedArticles[index];
                return NewsListItem(
                  imageUrl: article.imageUrl ?? '',
                  title: article.tital, // <-- اتصلحت هنا
                  source: article.sourceName,
                  timeAgo: article.publishedAt?.substring(0, 10) ?? '',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetailsScreen(
                          article: article,
                        ),
                      ),
                    );
                  },
                  onShareTap: () {
                    if (article.url != null) {
                      Share.share(article.url!);
                    }
                  },
                  onBookmarkTap: () {
                    context.read<BookmarkCubit>().toggleBookmark(article);
                  },
                  bookmarkIcon: const Icon(Icons.bookmark_rounded, color: Colors.greenAccent),
                );
              },
            );
          }

          // <-- السطر اللي كان ناقص عشان الكود يرضى يشتغل
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        },
      ),
    );
  }
}