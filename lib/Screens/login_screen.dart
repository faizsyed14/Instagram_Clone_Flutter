import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Screens/signup_screen.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/responsive/WebscreenLayout.dart';
import 'package:instagram_clone/responsive/mobileScreenLayout.dart';
import 'package:instagram_clone/responsive/response_layout.dart';
import 'package:instagram_clone/utlis/colors.dart';
import 'package:instagram_clone/utlis/global_variables.dart';
import 'package:instagram_clone/utlis/utils.dart';
import 'package:instagram_clone/widgets/Text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isloading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginuser() async {
    setState(() {
      _isloading = true;
    });
    String res = await authMethods().LoginMethod(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );
    if (res == "sucess") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            MobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebscreenLayout(),
          ),
        ),
      );
    } else {
      //
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = true;
    });
  }

  void navigatetosignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4)
            : const EdgeInsets.symmetric(horizontal: 32),
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
            const SizedBox(
              height: 64,
            ),
            //username
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
            //submit button
            InkWell(
              onTap: loginuser,
              child: Container(
                child: _isloading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : Text("Log in"),
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
                  child: Text("Don't you have an account?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: navigatetosignup,
                  child: Container(
                    child: Text(
                      "Sign up",
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
