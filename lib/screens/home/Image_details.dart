import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safe_encrypt/screens/colors/colors.dart';

class ImageDetails extends StatefulWidget {
  final String path;
  const ImageDetails({Key? key, required this.path}) : super(key: key);

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kdarkblue,
          title: const Text('Image Deatils'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  child: Image.file(
                    //load system image
                    File(widget.path), //system image path
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3 * 2.4,
                    fit: BoxFit.fill,
                  ),
                ),
                BottomAppBar(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.share,
                          color: kblue,
                          size: 50,
                        ),
                        Icon(
                          Icons.rotate_90_degrees_ccw_outlined,
                          color: kblue,
                          size: 50,
                        ),
                        InkWell(
                          onTap: () {
                            delete(widget.path);
                          },
                          child: Icon(
                            Icons.delete_forever,
                            color: kblue,
                            size: 50,
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ));
  }

  void delete(String path) {
    final decryptedDir = Directory(path);
    final encryptedDir = Directory('$path.aes');

    setState(() {
      encryptedDir.deleteSync(recursive: true);
      decryptedDir.deleteSync(recursive: true);
    });
  }
}
