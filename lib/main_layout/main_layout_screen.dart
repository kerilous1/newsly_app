import 'package:flutter/material.dart';
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
    const Center(child: Text('Search Screen', style: TextStyle(fontSize: 24, color: AppColors.textPrimaryColor))),
    const Center(child: Text('Saved Screen', style: TextStyle(fontSize: 24, color: AppColors.textPrimaryColor))),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_indexSelected],
      bottomNavigationBar:CustomBottomNavigation(
        indexSelected: _indexSelected,
        onItemSelected: (index) {
          setState(() {
            _indexSelected = index;
          });
        },

      )
    ) ;
  }
}
