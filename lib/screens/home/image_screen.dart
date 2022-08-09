import 'dart:io';

import 'package:file_cryptor/file_cryptor.dart';
import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_encrypt/screens/home/Image_details.dart';
import 'package:path/path.dart' as path;

import '../../utils/helper_methods.dart';
import '../colors/colors.dart';

class ImageScreen extends StatefulWidget {
  final String path;
  const ImageScreen({Key? key, required this.path}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  List<String> decryptedImages = [];

  @override
  void initState() {
    decryptImages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        deleteDecryptedImages(decryptedImages);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Images')),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: HawkFabMenu(
              blur: 155.8,
              backgroundColor: kliteblue,
              openIcon: Icons.add,
              closeIcon: Icons.close,
              items: [
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
              body: _isLoading ? const Center(child: CircularProgressIndicator()) : loadPhotos()),
        ),
      ),
    );
  }

  // loading all photos in the folder
  loadPhotos() {
    if (decryptedImages.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          padding: const EdgeInsets.all(8.0),
          itemCount: decryptedImages.length,
          itemBuilder: (context, index) {
            String imgPath = decryptedImages[index];

            return GestureDetector(
              onDoubleTap: () => delete(imgPath),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ImageDetails(path: imgPath))),
              child: Card(elevation: 8.0, child: Hero(tag: imgPath, child: Image.file(File(imgPath), fit: BoxFit.fill))),
            );
          },
        ),
      );
    } else {
      return Center(
        child: Container(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: const Text("Sorry, no images were found.", style: TextStyle(fontSize: 18.0)),
        ),
      );
    }
  }

  // import photos inside the folder
  importPhotos() async {
    String imageName = '';
    String fileType = '';

    final List<XFile>? imageList = await _picker.pickMultiImage();

    if (imageList != null) {
      for (XFile image in imageList) {
        fileType = path.extension(image.path);
        imageName = '${DateTime.now().microsecondsSinceEpoch.toString()}$fileType';

        File fileToSave = File(image.path);
        fileToSave.copy('${widget.path}/$imageName');

        await encryptFiles(imageName, '$imageName.aes');
        setState(() => decryptedImages.add('${widget.path}/$imageName'));
      }
    }
  }

  // take photos inside the folder
  takePhoto() async {
    String imageName = '';
    String fileType = '';

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      fileType = path.extension(image.path);
      imageName = '${DateTime.now().microsecondsSinceEpoch.toString()}$fileType';

      File fileToSave = File(image.path);
      fileToSave.copy('${widget.path}/$imageName');

      await encryptFiles(imageName, '$imageName.aes');
      setState(() => decryptedImages.add('${widget.path}/$imageName'));
    }
  }

  // decrypt images when opening folder
  void decryptImages() async {
    setState(() => _isLoading = true);

    FileCryptor fileCryptor = FileCryptor(key: 'Your 32 bit key.................', iv: 16, dir: widget.path);
    String currentDirectory = fileCryptor.getCurrentDir();
    String imageName;
    String outputName;

    Directory _openedFolder = Directory(widget.path);
    List<String> encryptedImages = _openedFolder.listSync().map((item) => item.path).where((item) => item.endsWith(".aes")).toList(growable: true);

    if (encryptedImages.isNotEmpty) {
      for (var image in encryptedImages) {
        imageName = image.replaceAll('$currentDirectory/', '');
        outputName = imageName.replaceAll('.aes', '');
        File decryptedFile = await fileCryptor.decrypt(inputFile: imageName, outputFile: outputName);
        decryptedImages.add(decryptedFile.path);
      }

      setState(() => _isLoading = false);
    } else {
      setState(() => _isLoading = false);
    }
  }

  // delete decrypted images when closing folder (going back)
  void deleteDecryptedImages(List<String> decryptedFiles) async {
    if (decryptedFiles.isNotEmpty) {
      for (var image in decryptedFiles) {
        final dir = Directory(image);
        dir.deleteSync(recursive: true);
      }
    }
  }

  // delete single file (both decrypted and encrypted versions)
  void delete(String path) {
    final decryptedDir = Directory(path);
    final encryptedDir = Directory('$path.aes');
    setState(() {
      decryptedImages.remove(path);
      decryptedDir.deleteSync(recursive: true);
      encryptedDir.deleteSync(recursive: true);
    });
  }
}
