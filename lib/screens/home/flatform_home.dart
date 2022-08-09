import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:safe_encrypt/screens/colors/colors.dart';

import '../../utils/helper_methods.dart';
import '../album_covers/album_covers.dart';
import '../components/platform_folder.dart';
import '../settings/settings.dart';
import 'image_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _folderName = TextEditingController();

  final Directory _directory = Directory(
      '/storage/emulated/0/Android/data/com.example.safe_encrypt/files');
  List<FileSystemEntity> folderList = [];

  @override
  void initState() {
    requestPermission(Permission.storage);
    getFolderList();

    super.initState();
  }

  @override
  void dispose() {
    _folderName.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('keepsafe'),
        backgroundColor: kdarkblue,
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.account_circle),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.delete, color: Colors.white54),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.cloud, color: Colors.white),
              onPressed: () {}),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          autofocus: true,
                          child: Text('Settings',
                              style: TextStyle(color: kblack, fontSize: 17)),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Settings())),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          autofocus: true,
                          child: Text('Help',
                              style: TextStyle(color: kblack, fontSize: 17)),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: HawkFabMenu(
          blur: 155.8,
          backgroundColor: kliteblue,
          openIcon: Icons.add,
          closeIcon: Icons.close,
          items: [
            HawkFabMenuItem(
                label: 'Add album',
                ontap: () async => showCreateFolderDialog(context),
                icon: const Icon(Icons.add_to_photos_rounded),
                color: Colors.black38,
                labelColor: Colors.white,
                labelBackgroundColor: kliteblue),
            HawkFabMenuItem(
                label: 'Import photos',
                ontap: () async => importPhotos(),
                icon: const Icon(Icons.photo),
                color: const Color.fromRGBO(0, 0, 0, 0.38),
                labelColor: Colors.white,
                labelBackgroundColor: kliteblue),
            HawkFabMenuItem(
              label: 'Take photo',
              ontap: () async => takePhoto(),
              icon: const Icon(Icons.camera_alt),
              color: Colors.black38,
              labelColor: Colors.white,
              labelBackgroundColor: kliteblue,
            ),
          ],
          body: GridView.builder(
              itemCount: folderList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, index) {
                String oneEntity = folderList[index].toString();
                String folderName =
                    oneEntity.split('/').last.replaceAll("'", '');

                return InkWell(
                  child: PlatformAlbum(
                      // selected image of folder cover
                      // use provider (FolderCoverImageProvider)
                      image: Image.asset(
                          Provider.of<FolderCoverImageProvider>(context,
                                  listen: false)
                              .imgList[index],
                          fit: BoxFit.fill),
                      title: folderName,
                      album: 'Album Settings',
                      isDelete: index == 0 ? false : true,
                      path: folderList[index].path),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ImageScreen(path: folderList[index].path))),
                );
              }),
        ),
      ),
    );
  }

  // create folder dialog
  showCreateFolderDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: double.infinity,
              height: 250,
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                    controller: _folderName,
                    decoration: const InputDecoration(hintText: 'Folder name')),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('CANCEL')),
                    TextButton(
                        onPressed: () async {
                          var result = await createFolder(_folderName.text);
                          setState(() {
                            _folderName.clear();
                          });
                          Navigator.pop(context);

                          initState();
                        },
                        child: const Text('CREATE')),
                  ],
                )
              ]),
            ),
          );
        });
  }

  // load app folders
  getFolderList() async {
    folderList = _directory.listSync(followLinks: true);
    folderList.removeWhere((item) => item.runtimeType.toString() == '_File');
  }

  // creating folders
  Future<bool> createFolder(String folderName) async {
    Directory? directory;

    try {
      if (Platform.isAndroid) {
        if (await requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          log(directory!.path);

          String newPath = '';
          List<String> folders = directory.path.split("/");

          for (int i = 1; i < folders.length; i++) {
            String folder = folders[i];
            newPath += "/$folder";
          }

          newPath = "$newPath/$folderName";

          directory = Directory(newPath);
          log(directory.path);
          getFolderList();
        } else {
          return false;
        }
      } else {
        if (await requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
