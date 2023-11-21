import 'package:flutter/material.dart';
import 'package:instagram_clone/utlis/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utlis/global_variables.dart';
import 'package:instagram_clone/widgets/post_card.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: width > webScreenSize
                  ? webBackgroundColor
                  : mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                "assets/ic_instagram.svg",
                color: primaryColor,
                height: 32,
              ),
              actions: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.messenger_outline))
              ],
            ),

      ///have no idea whatsa going on here
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (cntext, index) => Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: width > webScreenSize ? width * 0.3 : 0,
                        vertical: width > webScreenSize ? 15 : 0),
                    // padding: MediaQuery.of(context).size.width > webScreenSize
                    //     ? EdgeInsets.symmetric(
                    //         horizontal: MediaQuery.of(context).size.width)
                    //     : const EdgeInsets.symmetric(horizontal: 32),
                    child: PostCard(snap: snapshot.data!.docs[index].data()),
                  ));
        },
      ),
    );
  }
}
