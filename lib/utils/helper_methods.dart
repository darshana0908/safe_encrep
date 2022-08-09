// encrypting files
import 'dart:io';

import 'package:file_cryptor/file_cryptor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

const defaultFolder = '/storage/emulated/0/Android/data/com.example.safe_encrypt/files/Main Album/';
final ImagePicker _picker = ImagePicker();

Future<File> encryptFiles(String inputFileName, String outputFileName) async {
  FileCryptor fileCryptor = FileCryptor(
    key: 'Your 32 bit key.................',
    iv: 16,
    dir: defaultFolder,
  );

  return fileCryptor.encrypt(inputFile: inputFileName, outputFile: outputFileName);
}

// deleting files
void delete(String path) {
  final dir = Directory(path);
  dir.deleteSync(recursive: true);
}

// importing photos to default folder
importPhotos() async {
  String imageName = '';
  String fileType = '';

  final List<XFile>? imageList = await _picker.pickMultiImage();

  if (imageList != null) {
    for (XFile image in imageList) {
      fileType = path.extension(image.path);
      imageName = '${DateTime.now().microsecondsSinceEpoch.toString()}$fileType';

      File fileToSave = File(image.path);
      fileToSave.copy('$defaultFolder$imageName');

      await encryptFiles(imageName, '$imageName.aes');
      delete('$defaultFolder$imageName');
    }
  }
}

// taking photos from camera to default folder
takePhoto() async {
  String imageName = '';
  String fileType = '';

  final XFile? image = await _picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    fileType = path.extension(image.path);
    imageName = '${DateTime.now().microsecondsSinceEpoch.toString()}$fileType';

    File fileToSave = File(image.path);
    fileToSave.copy('$defaultFolder$imageName');

    await encryptFiles(imageName, '$imageName.aes');
    delete('$defaultFolder$imageName');
  }
}

// requesting permission
Future<bool> requestPermission(Permission permission) async {
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
