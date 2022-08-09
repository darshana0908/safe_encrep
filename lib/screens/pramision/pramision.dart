import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_encrypt/screens/colors/colors.dart';

import '../sign_signup/sign_and_signup.dart';

class Permissions extends StatefulWidget {
  const Permissions({Key? key}) : super(key: key);

  @override
  _PermissionsState createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
  String foldername = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kdarkblue,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: 150),
              SvgPicture.asset(
                'assets/pramisson_1.svg',
                width: 150,
              ),
              const SizedBox(height: 100),
              Text(
                'Keepsafe needs access to  your file storage',
                style: TextStyle(fontSize: 25, color: kwhite),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15),
              Text(
                'this allows keepsafe to access and  encrypt your photos or videos.',
                style: TextStyle(fontSize: 17, color: kgray),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: () async {
                  if (await _requestPermission(Permission.storage)) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignAndSignup()));
                    // Either the permission was already granted before or the user just granted it.
                  }

                  // You can request multiple permissions at once.
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.location,
                    Permission.storage,
                  ].request();
                  print(statuses[Permission.location]);
                },
                child: Container(
                  alignment: Alignment.center,
                  color: kblue,
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'GRANT ACCESS',
                    style: TextStyle(fontSize: 17, color: kwhite, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              TextButton(
                child: const Text('EXIT'),
                onPressed: () => exit(0),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  // Future<String> createFolderInAppDocDir(String folderName) async {
  //   //Get this App Document Directory

  //   final Directory _appDocDir = await getApplicationDocumentsDirectory();
  //   //App Document Directory + folder name
  //   final Directory _appDocDirFolder = Directory(
  //       '/storage/emulated/0/Android/data/com.example.safe_encrypt/files');

  //   if (await _appDocDirFolder.exists()) {
  //     //if folder already exists return path
  //     return _appDocDirFolder.path;
  //   } else {
  //     //if folder not exists create folder and then return its path
  //     final Directory _appDocDirNewFolder =
  //         await _appDocDirFolder.create(recursive: true);
  //     print(_appDocDirFolder);
  //     print('******');
  //     return _appDocDirNewFolder.path;
  //   }
  // }
}
