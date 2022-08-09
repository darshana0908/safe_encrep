import 'package:flutter/material.dart';
import 'package:safe_encrypt/screens/colors/colors.dart';

import '../album_covers/album_covers.dart';

class AlbumSettings extends StatefulWidget {
  const AlbumSettings({Key? key}) : super(key: key);

  @override
  State<AlbumSettings> createState() => _AlbumSettingsState();
}

class _AlbumSettingsState extends State<AlbumSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kdarkblue,
        title: const Text('Album settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'General',
              style: TextStyle(color: kblue, fontSize: 20),
            ),
          ),
          Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(color: kblack, fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Main Album',
                        style: TextStyle(fontSize: 17, color: kgray, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Divider(
            color: kblack,
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Album Cover',
                          style: TextStyle(color: kblack, fontSize: 19, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Custom',
                            style: TextStyle(fontSize: 17, color: kgray, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/icon3.JPG',
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AlbuCovers()));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: kblack,
          ),
        ]),
      ),
    );
  }
}
