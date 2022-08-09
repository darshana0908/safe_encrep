import 'package:flutter/material.dart';
import 'package:safe_encrypt/screens/colors/colors.dart';

import '../Access/welcome_page.dart';

class NewSignupPage extends StatefulWidget {
  const NewSignupPage({Key? key}) : super(key: key);

  @override
  State<NewSignupPage> createState() => _NewSignupPageState();
}

class _NewSignupPageState extends State<NewSignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdarkblue,
      body: SafeArea(
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
              padding: const EdgeInsets.all(40.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  child: const Text(
                    "Add email an in case your froget.",
                    style: TextStyle(color: Colors.white60, fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(
                      hintText: 'name',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                      label: Text('Name', style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500))),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: 'Exsampla.com ',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                      label: Text('Email', style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500))),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 80,
                    height: 50,
                    color: kliteblue,
                    child: const Text(
                      'Finish',
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Welcomepage(),
                        ));
                  },
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
