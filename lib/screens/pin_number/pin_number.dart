import 'dart:io';

import 'package:file_cryptor/file_cryptor.dart';
import 'package:flutter/material.dart';
import 'package:safe_encrypt/screens/colors/colors.dart';

import '../Access/access_code.dart';
import '../components/pin_key_pad.dart';

class PinNumber extends StatefulWidget {
  const PinNumber({Key? key}) : super(key: key);

  @override
  State<PinNumber> createState() => _PinNumberState();
}

class _PinNumberState extends State<PinNumber> {
  final TextEditingController controler_pin = TextEditingController();
  bool backspacecolorchange = false;
  String key = 'Your 32 bit key.................';
  String ff = 'f';
  final Directory _directory = Directory('/storage/emulated/0/Android/data/com.example.safe_encrypt/files');
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
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const Text(
                    "Let's get you set up.\n First, choose a PIN",
                    style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    style: TextStyle(color: kwhite, fontSize: 35),
                    controller: controler_pin,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.backspace_rounded,
                          color: backspacecolorchange ? kgray : kwhite,
                        ),
                        onPressed: () {
                          controler_pin.text = controler_pin.text.substring(0, controler_pin.text.length - 1);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PinKeyPad(
                            keypad: '1',
                            click: () {
                              setState(() {
                                backspacecolorchange = false;

                                controler_pin.text = controler_pin.text + '1';
                              });
                            }),
                        PinKeyPad(
                            keypad: '2',
                            click: () {
                              setState(() {
                                backspacecolorchange = false;

                                controler_pin.text = controler_pin.text + '2';
                              });
                            }),
                        PinKeyPad(
                            keypad: '3',
                            click: () {
                              setState(() {
                                backspacecolorchange = false;

                                controler_pin.text = controler_pin.text + '3';
                              });
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PinKeyPad(
                            keypad: '4',
                            click: () {
                              setState(() {
                                backspacecolorchange = false;

                                controler_pin.text = controler_pin.text + '4';
                              });
                            }),
                        PinKeyPad(
                            keypad: '5',
                            click: () {
                              setState(() {
                                backspacecolorchange = false;

                                controler_pin.text = controler_pin.text + '5';
                              });
                            }),
                        PinKeyPad(
                            keypad: '6',
                            click: () {
                              setState(() {
                                backspacecolorchange = false;

                                controler_pin.text = controler_pin.text + '6';
                              });
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PinKeyPad(
                            keypad: '7',
                            click: () {
                              setState(() {
                                backspacecolorchange = false;

                                controler_pin.text = controler_pin.text + '7';
                              });
                            }),
                        PinKeyPad(
                            keypad: '8',
                            click: () {
                              setState(() {
                                backspacecolorchange = false;

                                controler_pin.text = controler_pin.text + '8';
                              });
                            }),
                        PinKeyPad(
                            keypad: '9',
                            click: () {
                              setState(() {
                                backspacecolorchange = false;

                                controler_pin.text = controler_pin.text + '9';
                              });
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        '',
                        style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 190,
                      ),
                      PinKeyPad(
                          keypad: '0',
                          click: () {
                            setState(() {
                              backspacecolorchange = false;

                              controler_pin.text = controler_pin.text + '0';
                            });
                          }),
                      const SizedBox(
                        width: 115,
                      ),
                      IconButton(
                        onPressed: () {
                          main();
                          //   if (controler_pin.text == key) {
                          //     main();
                          //     print('okkkkkk');
                          //   } else {
                          //     print('qqqqqqqqqqqqqqqqqqqq');
                          //   }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AccessCode(),
                              ));
                        },
                        icon: Icon(
                          Icons.check_circle,
                          color: kwhite,
                          size: 50,
                        ),
                      )
                    ],
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void main() async {
    FileCryptor fileCryptor = FileCryptor(
      key: "Your 32 bit key.................",
      iv: 16,
      dir: '/storage/emulated/0/Android/data/com.example.safe_encrypt/',
    );

    File encryptedFile = await fileCryptor.encrypt(inputFile: "files.txt", outputFile: "files.aes");

    print(encryptedFile.absolute);

    // File decryptedFile =
    //     await fileCryptor.decrypt(inputFile: "New.text", outputFile: "New.jpg");
    // print(decryptedFile.absolute);
  }
}
