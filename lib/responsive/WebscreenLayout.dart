import 'package:flutter/material.dart';
import 'package:instagram_clone/utlis/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utlis/global_variables.dart';

class WebscreenLayout extends StatefulWidget {
  const WebscreenLayout({super.key});

  @override
  State<WebscreenLayout> createState() => _WebscreenLayoutState();
}

class _WebscreenLayoutState extends State<WebscreenLayout> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void Navigationtap(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPagechanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: SvgPicture.asset(
            "assets/ic_instagram.svg",
            color: primaryColor,
            height: 32,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigationtap(0);
              },
              icon: Icon(Icons.home),
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            IconButton(
              onPressed: () {
                Navigationtap(1);
              },
              icon: Icon(Icons.search),
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            IconButton(
              onPressed: () {
                Navigationtap(2);
              },
              icon: Icon(Icons.add_a_photo),
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            IconButton(
              onPressed: () {
                Navigationtap(3);
              },
              icon: Icon(Icons.favorite),
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            IconButton(
              onPressed: () {
                Navigationtap(4);
              },
              icon: Icon(Icons.person),
              color: _page == 4 ? primaryColor : secondaryColor,
            )
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: homeScreenitems,
          controller: pageController,
          onPageChanged: onPagechanged,
        ));
  }
}
