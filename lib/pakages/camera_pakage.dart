import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraPakage {
  CameraPakage._();

  static Future<File?> getImage(List<File?> images) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    File? img = File(image!.path);
    img = await cropImage(img);
    if (img != null) {
      return img;
    }
  }

  static Future<List<File>> getImages(List<File?> images) async {
    final images = await ImagePicker().pickMultiImage();
    List<File> imgs = [];
    for (XFile image in images) {
      imgs.add(File(image.path));
    }
    imgs = await cropImages(imgs);
    return imgs;
  }

  static Future<List<File>> getImagesNoCrop(List<File?> images) async {
    final images = await ImagePicker().pickMultiImage();
    List<File> imgs = [];
    for (XFile image in images) {
      imgs.add(File(image.path));
    }
    return imgs;
  }

  static Future cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 3),
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  static Future cropImages(List<File?> images) async {
    List<File> croppedImages = [];
    for (File? image in images) {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      );
      croppedImages.add(File(croppedImage!.path));
    }
    if (croppedImages == null) return null;
    return croppedImages;
  }
}
