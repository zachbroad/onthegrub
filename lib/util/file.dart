import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getFileFromAssets(String fileName) async {
  final byteData = await rootBundle.load('assets/$fileName');

  final file = File('${(await getTemporaryDirectory()).path}/$fileName');
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  return file;
}

Future<File> getImageFromUserGallery() async {
  final _picker = ImagePicker();
  PickedFile image = await _picker.getImage(source: ImageSource.gallery);
  if (image != null)
    return File(image.path);
  else
    return null;
}

Future<File> getImageFromUserCamera() async {
  final _picker = ImagePicker();
  PickedFile image = await _picker.getImage(source: ImageSource.camera);
  return File(image.path);
}
