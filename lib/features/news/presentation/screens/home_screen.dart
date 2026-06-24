import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/utils/service_locator.dart';
import 'package:newsly/features/news/presentation/cubit/news_cubit.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../bookmarks/presentation/cubit/bookmark_cubit.dart';
import '../cubit/category_news_cubit.dart';
import '../cubit/category_news_state.dart';
import '../cubit/news_state.dart';
import '../widgets/breaking_news_item.dart';
import '../widgets/news_list_item.dart';
import 'article_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> categories = const [
    'all', 'business', 'entertainment', 'health', 'science', 'sports', 'technology'
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<NewsCubit>()..fetchTopHeadlines()),
        BlocProvider(create: (context) => getIt<CategoryNewsCubit>()..fetchCategoryNews('all')),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Newsly.'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded)
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(
                  'Breaking News',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              // Breaking news
              BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return const SizedBox(
                      height: 300,
                      child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                    );
                  } else if (state is NewsError) {
                    return SizedBox(
                      height: 310,
                      child: Center(
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    );
                  } else if (state is NewsLoaded) {
                    final articles = state.articles;
                    if (articles.isEmpty) {
                      return const SizedBox(
                        height: 310,
                        child: Center(child: Text('No breaking news right now.')),
                      );
                    }
                    return SizedBox(
                      height: 310,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: articles.length > 5 ? 5 : articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];

                          return BlocBuilder<BookmarkCubit, BookmarkState>(
                            builder: (context, bookmarkState) {
                              // <-- صلحنا الجريمة هنا: بننادي على isSaved اللي لسه ضايفينها
                              final isSaved = context.read<BookmarkCubit>().isSaved(article.url ?? '');

                              return BreakingNewsItem(
                                imageUrl: article.imageUrl ?? '',
                                title: article.tital, // خليتها title، لو ضربت عندك رجعها tital
                                source: article.sourceName,
                                timeAgo: (article.publishedAt != null && article.publishedAt!.length >= 10)
                                    ? article.publishedAt!.substring(0, 10)
                                    : '',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticleDetailsScreen(
                                          article: article,
                                        )
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
                                // <-- صلحنا الفراغ العاطفي هنا
                                bookmarkIcon: Icon(
                                  isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                  color: isSaved ? Colors.greenAccent : Colors.white70,
                                  size: 22,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox(height: 300);
                },
              ),

              const SizedBox(height: 25),

              // Category Bar
              SizedBox(
                height: 40,
                child: BlocBuilder<CategoryNewsCubit, CategoryNewsState>(
                  builder: (context, state) {
                    final currentCat = context.read<CategoryNewsCubit>().currentCategory;

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final isSelected = cat == currentCat;

                        return GestureDetector(
                          onTap: () {
                            if (!isSelected) {
                              context.read<CategoryNewsCubit>().fetchCategoryNews(cat);
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryColor : AppColors.surfaceColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? AppColors.primaryColor : AppColors.primaryColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                cat[0].toUpperCase() + cat.substring(1),
                                style: TextStyle(
                                  color: isSelected ? Colors.white : AppColors.textSecondaryColor,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Category News List
              BlocBuilder<CategoryNewsCubit, CategoryNewsState>(
                builder: (context, state) {
                  if (state is CategoryNewsLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                    );
                  } else if (state is CategoryNewsError) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    );
                  } else if (state is CategoryNewsLoaded) {
                    final articles = state.articles;
                    if (articles.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Center(child: Text('No news found for this category.')),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];

                        return BlocBuilder<BookmarkCubit, BookmarkState>(
                          builder: (context, bookmarkState) {
                            // <-- صلحنا الجريمة هنا كمان
                            final isSaved = context.read<BookmarkCubit>().isSaved(article.url ?? '');

                            return NewsListItem(
                              imageUrl: article.imageUrl ?? '',
                              title: article.tital,
                              source: article.sourceName,
                              timeAgo: (article.publishedAt != null && article.publishedAt!.length >= 10)
                                  ? article.publishedAt!.substring(0, 10)
                                  : '',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticleDetailsScreen(
                                          article: article,
                                        )
                                    )
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
                              bookmarkIcon: Icon(
                                isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                color: isSaved ? Colors.greenAccent : AppColors.textSecondaryColor,
                                size: 20,
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}