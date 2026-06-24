import 'package:flutter/material.dart';
import 'package:newsly/splash_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/service_locator.dart';
import 'main_layout/main_layout_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('bookMarkBox');

  setServiceLocator();

  runApp(const NewslyApp());
}

class NewslyApp extends StatelessWidget {
  const NewslyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newsly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home:const SplashScreen(),
    );
  }
}

