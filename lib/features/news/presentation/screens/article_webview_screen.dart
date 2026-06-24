import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/theme/app_colors.dart';

class ArticleWebviewScreen extends StatefulWidget {
  final String url;
  final String sourceName;
  const ArticleWebviewScreen({super.key,
    required this.url,
    required this.sourceName
  });

  @override
  State<ArticleWebviewScreen> createState() => _ArticleWebviewScreenState();
}

class _ArticleWebviewScreenState extends State<ArticleWebviewScreen> {
  late final WebViewController _controller;
  bool isLoading = true;

  void initState(){
    super.initState();
    _controller=WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (String url){
          setState(() {
            isLoading=false;
          });
        }
      )
    )..loadRequest(Uri.parse(widget.url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sourceName),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if(isLoading)
            const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor,),
            )
        ],
      ),
    );
  }
}
