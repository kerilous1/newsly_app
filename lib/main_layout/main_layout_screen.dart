import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // <-- 1. استدعاء البلوك
import 'package:newsly/core/utils/service_locator.dart'; // <-- 2. استدعاء getIt
import 'package:newsly/features/bookmarks/presentation/cubit/bookmark_cubit.dart'; // <-- 3. استدعاء الكيوبيت

import 'package:newsly/features/bookmarks/presentation/screen/saved_screen.dart';
import 'package:newsly/features/search/search_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_bottom_navigation.dart';
import '../features/news/presentation/screens/home_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _indexSelected = 0;
  final List<Widget> _screens =[
    const HomeScreen(),
    const SearchScreen(),
    const SavedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // <-- لفينا الـ Scaffold كله بالـ BlocProvider
    return BlocProvider(
      create: (context) => getIt<BookmarkCubit>()..getSavedArticles(),
      child: Scaffold(
          body: _screens[_indexSelected],
          bottomNavigationBar: CustomBottomNavigation(
            indexSelected: _indexSelected,
            onItemSelected: (index) {
              setState(() {
                _indexSelected = index;
              });
            },
          )
      ),
    );
  }
}