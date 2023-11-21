import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/login_screen.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/responsive/WebscreenLayout.dart';
import 'package:instagram_clone/responsive/mobileScreenLayout.dart';
import 'package:instagram_clone/responsive/response_layout.dart';
import 'package:instagram_clone/utlis/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// import 'package:instagram_clone/utlis/dimensions.dart';

void main() async {
  //it ensures the program is initialized
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBZ5c-d4N0vETVNgctsrAOREoJBmhOqltI",
      appId: "1:884662268980:web:36018cf69fdbcc11990661",
      messagingSenderId: "884662268980",
      projectId: "instagram-clone-726be",
      storageBucket: "instagram-clone-726be.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: Scaffold(
          // body: ResponsiveLayout(
          //   MobileScreenLayout: MobileScreenLayout(),
          //   webScreenLayout: WebscreenLayout(),
          // ),
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                // Checking if the snapshot has any data or not
                if (snapshot.hasData) {
                  // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                  return const ResponsiveLayout(
                    MobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebscreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }

              // means connection to future hasnt been made yet
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const LoginScreen();
            },
          ),
        ),
      ),
    );
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import "package:instagram_clone/provider/user_provider.dart";
// import 'package:instagram_clone/responsive/mobileScreenlayout.dart';
// import 'package:instagram_clone/responsive/response_layout.dart';
// import 'package:instagram_clone/responsive/webscreenLayout.dart';
// import 'package:instagram_clone/screens/login_screen.dart';
// import 'package:instagram_clone/utlis/colors.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // initialise app based on platform- web or mobile
//   if (kIsWeb) {
//     await Firebase.initializeApp(
//       options: const FirebaseOptions(
//           apiKey: "AIzaSyBZ5c-d4N0vETVNgctsrAOREoJBmhOqltI",
//           appId: "1:884662268980:web:36018cf69fdbcc11990661",
//           messagingSenderId: "884662268980",
//           projectId: "instagram-clone-726be",
//           storageBucket: 'instagram-clone-726be.appspot.com'),
//     );
//     // if (kIsWeb) {
// //     await Firebase.initializeApp(
// //         options: const FirebaseOptions(
// //       apiKey: "AIzaSyBZ5c-d4N0vETVNgctsrAOREoJBmhOqltI",
// //       appId: "1:884662268980:web:36018cf69fdbcc11990661",
// //       messagingSenderId: "884662268980",
// //       projectId: "instagram-clone-726be",
// //       storageBucket: "instagram-clone-726be.appspot.com",
// //     ));
//   } else {
//     await Firebase.initializeApp();
//   }
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => UserProvider(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Instagram Clone',
//         theme: ThemeData.dark().copyWith(
//           scaffoldBackgroundColor: mobileBackgroundColor,
//         ),
//         home: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.active) {
//               // Checking if the snapshot has any data or not
//               if (snapshot.hasData) {
//                 // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
//                 return ResponsiveLayout(
//                   mobileScreenLayout: MobileScreenLayout(),
//                   webScreenLayout: WebScreenLayout(),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text('${snapshot.error}'),
//                 );
//               }
//             }

//             // means connection to future hasnt been made yet
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             return const LoginScreen();
//           },
//         ),
//       ),
//     );
//   }
// }
