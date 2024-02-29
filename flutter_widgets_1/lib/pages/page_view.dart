import 'package:flutter/material.dart';

import 'camera_page.dart';
import 'feed_page.dart';
import 'search_page.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PageView Kullanımı"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const BouncingScrollPhysics(),
              // reverse: true,
              pageSnapping: true,
              onPageChanged: (index) {},
              controller: _pageController,
              // scrollDirection: Axis.horizontal,
              children: const [
                CameraPage(),
                FeedPage(),
                SearchPage(),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // currentPage--;
                    // _pageController.jumpToPage(currentPage);
                    _pageController.previousPage(duration: Duration(milliseconds: 1000), curve: Curves.easeInCubic);
                  },
                  child: const Text("Önceki"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    currentPage++;
                    _pageController.jumpToPage(currentPage);
                  },
                  child: const Text("Sonraki"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
