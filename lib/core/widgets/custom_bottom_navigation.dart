import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int indexSelected;
  final Function(int) onItemSelected;
  const CustomBottomNavigation({
    super.key,
    required this.indexSelected,
    required this.onItemSelected
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String,dynamic>> navItems = [
      {'icon':Icons.home_rounded,'label':'Home'},
      {'icon':Icons.search_rounded,'label':'Search'},
      {'icon':Icons.bookmark_border_rounded,'label':'Saved'},
    ];
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:List.generate(navItems.length, (index){
          bool isSelected = indexSelected == index;
          return GestureDetector(
            onTap: ()=>onItemSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: isSelected
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: isSelected
                  ? Border.all(color: AppColors.primaryColor,width: 1.5)
                  : Border.all(color:Colors.transparent, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(
                    navItems[index]['icon'],
                    color: isSelected
                    ?AppColors.primaryColor
                    :AppColors.textSecondaryColor,
                    size: 16,
                  ),
                  if(isSelected)...[
                    const SizedBox(width: 8,),
                    Text(
                      navItems[index]['label'],
                      style: const TextStyle(
                        color: AppColors.textSecondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ]
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
