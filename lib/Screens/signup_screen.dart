import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Screens/login_screen.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/responsive/WebscreenLayout.dart';
import 'package:instagram_clone/responsive/mobileScreenLayout.dart';
import 'package:instagram_clone/responsive/response_layout.dart';
import 'package:instagram_clone/utlis/colors.dart';
import 'package:instagram_clone/utlis/utils.dart';
import 'package:instagram_clone/widgets/Text_field.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void navigatetologinscreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
  }

  void Signupuser() async {
    setState(() {
      _isloading = true;
    });
    String res = await authMethods().signupUser(
        email: _emailcontroller.text,
        passwords: _passwordcontroller.text,
        username: _usernamecontroller.text,
        bio: _biocontroller.text,
        File: _image!);
    setState(() {
      _isloading = false;
    });
    if (res != "sucess") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
              MobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebscreenLayout())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //img
            SvgPicture.asset(
              "assets/ic_instagram.svg",
              color: primaryColor,
              height: 64,
            ),
            SizedBox(
              height: 24,
            ),
            //circular file imahe to be selected
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/1200px-Default_pfp.svg.png",
                        ),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 24,
            ),
            //usrname
            TextFieldinput(
              hintText: "Enter your username",
              textEditingController: _usernamecontroller,
              textInputType: TextInputType.text,
            ),

            SizedBox(
              height: 24,
            ),
            //email
            TextFieldinput(
              hintText: "Enter your email",
              textEditingController: _emailcontroller,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 24,
            )
            //password
            ,
            TextFieldinput(
              hintText: "Enter your Password",
              textEditingController: _passwordcontroller,
              textInputType: TextInputType.text,
              isPass: true,
            ),
            SizedBox(
              height: 24,
            ),
            //bio
            TextFieldinput(
              hintText: "Enter your bio",
              textEditingController: _biocontroller,
              textInputType: TextInputType.text,
            ),

            SizedBox(
              height: 24,
            ),
            //submit button
            InkWell(
              onTap: Signupuser,
              child: Container(
                child: _isloading
                    ? CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : Text("Sign up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //forget creditials
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Already have a account? "),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: navigatetologinscreen,
                  child: Container(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
