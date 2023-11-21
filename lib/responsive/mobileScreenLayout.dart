import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utlis/colors.dart';
import 'package:instagram_clone/utlis/global_variables.dart';
// import 'package:instagram_clone/utlis/global_variables.dart';
// import 'package:instagram_clone/models/user.dart';
// import 'package:instagram_clone/provider/user_provider.dart';
// import 'package:provider/provider.dart';
// import "package:cloud_firestore/cloud_firestore.dart";
// import 'package:firebase_auth/firebase_auth.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // String Username = "";
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getusername();
  // }

  // void getusername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     /// has to explicitily declare as string because it is an object
  //     /// ///
  //     /// //
  //     /// /
  //     ///
  //     Username = (snap.data() as Map<String, dynamic>)["username"];
  //     //need to revise it
  //   });
  //   // print(snap.data());
  // }
// Addpostscreen(){
//   return user == null? const Center(
// child: CircularProgressIndicator(
// ),): _file == null? Center(child: Text(""),);
// }

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
  }

  void onPagechanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        children: homeScreenitems,
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPagechanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            label: "",
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            label: "",
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            label: "",
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            label: "",
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            label: "",
            backgroundColor: primaryColor,
          ),
        ],
        onTap: Navigationtap,
      ),
    );
  }
}
