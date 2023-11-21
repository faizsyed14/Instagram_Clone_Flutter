import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/login_screen.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utlis/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/utlis/utils.dart';
import 'package:instagram_clone/widgets/followbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class AccountScreeen extends StatefulWidget {
  final String uid;
  const AccountScreeen({
    super.key,
    required this.uid,
  });

  @override
  State<AccountScreeen> createState() => _AccountScreeenState();
}

class _AccountScreeenState extends State<AccountScreeen> {
  var userData = {};
  int postlen = 0;
  int followerslen = 0;
  int followinglen = 0;
  bool isfollowing = false;
  bool isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isloading = true;
    });
    try {
      var Usersnap = await FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.uid)
          .get();
      //get post length
      //looking in the database
      var postsnap = await FirebaseFirestore.instance
          .collection("posts")
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      //getting the data from snap
      postlen = postsnap.docs.length;
      userData = Usersnap.data()!;
      followerslen = Usersnap.data()!["followers"].length;
      followinglen = Usersnap.data()!["following"].length;
      isfollowing = Usersnap.data()!["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: Text(userData["username"]),
              actions: [
                IconButton(
                    onPressed: () {
                      _firebaseAuth.signOut();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => LoginScreen()));
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: primaryColor,
                    ))
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              userData["photourl"],
                            ),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BuildstatColumn(postlen, "posts"),
                                    BuildstatColumn(followerslen, "followers"),
                                    BuildstatColumn(followinglen, "following"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? Followbutton(
                                            text: "Edit profile",
                                            backgrouncolor:
                                                mobileBackgroundColor,
                                            textcolor: primaryColor,
                                            bordercolor: Colors.grey,
                                            function: () {},
                                          )
                                        : isfollowing
                                            ? Followbutton(
                                                text: "Unfollow",
                                                backgrouncolor: Colors.white,
                                                textcolor: Colors.black,
                                                bordercolor: Colors.grey,
                                                function: () async {
                                                  await FireStoremethods()
                                                      .followuser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userData["uid"]);
                                                  setState(() {
                                                    isfollowing = false;
                                                    followerslen--;
                                                  });
                                                },
                                              )
                                            : Followbutton(
                                                text: "Follow",
                                                backgrouncolor:
                                                    mobileBackgroundColor,
                                                textcolor: Colors.white,
                                                bordercolor: Colors.blue,
                                                function: () async {
                                                  await FireStoremethods()
                                                      .followuser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userData["uid"]);
                                                  setState(() {
                                                    isfollowing = true;
                                                    followerslen++;
                                                  });
                                                },
                                              )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          userData["username"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 2),
                        child: Text(userData["bio"]),
                      ),
                      const Divider(),
                      FutureBuilder(
                          //getting the data or post for the same user
                          future: FirebaseFirestore.instance
                              .collection("posts")
                              .where("uid", isEqualTo: widget.uid)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return GridView.builder(
                              itemCount:
                                  (snapshot.data! as dynamic).docs.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 1.5,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                DocumentSnapshot snap =
                                    (snapshot.data! as dynamic).docs[index];
                                return Container(
                                  child: Image(
                                    image: NetworkImage(
                                        (snap.data()! as dynamic)["posturl"]),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                              shrinkWrap: true,
                            );
                          })
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Column BuildstatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
