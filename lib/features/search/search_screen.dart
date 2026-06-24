import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            Text(
              'Search for news from all over the world',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white, fontSize: 16),
                cursorColor: AppColors.primaryColor,
                maxLines: 1,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  //TODO implement search functionality
                },
                decoration: const InputDecoration(
                  hintText: 'Search for topics, politics, sports...',
                  hintStyle: TextStyle(color: AppColors.textSecondaryColor, fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded, color: AppColors.primaryColor, size: 22),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 32),

            //TODO implement result after search
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(
                      Icons.manage_search_rounded,
                      size: 72,
                      color: AppColors.textSecondaryColor.withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Find your interest',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter keywords to explore global updates.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
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