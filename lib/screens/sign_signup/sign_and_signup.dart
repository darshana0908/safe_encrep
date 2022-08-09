import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_encrypt/screens/colors/colors.dart';

import 'new_signup.dart';

class SignAndSignup extends StatefulWidget {
  const SignAndSignup({Key? key}) : super(key: key);

  @override
  _SignAndSignup createState() => _SignAndSignup();
}

class _SignAndSignup extends State<SignAndSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdarkblue,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: kwhite,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const SizedBox(height: 100),
                    SvgPicture.asset(
                      'assets/pramisson_1.svg',
                      width: 150,
                    ),
                    const SizedBox(height: 100),
                    Text(
                      ' Welcome To Keepsafe ',
                      style: TextStyle(fontSize: 25, color: kwhite),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'A safe place for your privet photos.',
                      style: TextStyle(fontSize: 17, color: kgray),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 135),
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        color: kblue,
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'NEW? SIGN UP HERE',
                          style: TextStyle(fontSize: 17, color: kwhite, fontWeight: FontWeight.w500),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NewSignupPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    TextButton(
                      child: const Text('LOG IN'),
                      onPressed: () {},
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
