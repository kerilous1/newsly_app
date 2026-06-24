import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'main_layout/main_layout_screen.dart'; // تأكد من صحة مسار المين لايوت عندك

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainLayoutScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Newsly.',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your Premium News Hub',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 2.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}