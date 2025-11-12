import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/core/services/dialog_service.dart';

class ImageServices {
  static String? getFileName(File? file) {
    return file == null ? null : basename(file.path);
  }

  static String convertToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    return 'data:image/jpeg;base64,$base64Image';
  }

  static String decodeBase64(String encoded) {
    String decoded = utf8.decode(base64Url.decode(encoded));
    return decoded;
  }

  static Future<Uint8List> imageUrlToUnit8List(String imageUrl) async {
    /// converting to Uint8List to pass to printer
    var response = await http.get(
      Uri.parse(
        imageUrl,
      ),
    );

    Uint8List bytesNetwork = response.bodyBytes;
    Uint8List imageBytesFromNetwork = bytesNetwork.buffer.asUint8List(
      bytesNetwork.offsetInBytes,
      bytesNetwork.lengthInBytes,
    );

    return imageBytesFromNetwork;
  }

  static Future<Uint8List> imagePathToUnit8List(String path) async {
    /// converting to Uint8List to pass to printer
    ByteData data = await rootBundle.load(path);
    Uint8List imageBytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return imageBytes;
  }

  static Future _pickImageFile({
    required ImageSource source,
  }) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
      );
      if (pickedFile == null) return;
      return File(pickedFile.path);
    } on PlatformException catch (e) {
      Log.error('Failed to pick image: $e');
    }
  }

  static Future<void> openImageFileSelectorDialog({
    required BuildContext context,
    required Function(File? imagefile) onPicked,
  }) async {
    await DialogService.customDialog(
      context: context,
      title: "Choose an image from",
      dialogPosition: Alignment.bottomCenter,
      actions: [
        /// image from camera
        KOutlinedButton(
          onPressed: () async {
            final imageFile = await _pickImageFile(source: ImageSource.camera);
            if (imageFile != null) {
              Get.back();
              if (imageFile is File) {
                onPicked(imageFile);
              }
            }
          },
          width: MediaQuery.of(context).size.width * 0.4,
          borderColor: kPrimaryColor,
          bgColor: kWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt,
                color: kPrimaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Camera',
                style: context.titleMedium(),
              ),
            ],
          ),
        ),

        /// image from gallery
        KOutlinedButton(
          onPressed: () async {
            final imageFile = await _pickImageFile(source: ImageSource.gallery);
            if (imageFile != null) {
              Get.back();
              if (imageFile is File) {
                onPicked(imageFile);
              }
            }
          },
          width: MediaQuery.of(context).size.width * 0.4,
          borderColor: kPrimaryColor,
          bgColor: kWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.image,
                color: kPrimaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Gallery',
                style: context.titleMedium(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Future _pickVideoFile({
    required ImageSource source,
  }) async {
    try {
      final pickedFile = await ImagePicker().pickVideo(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10),
      );

      XFile? xFilePick = pickedFile;
      if (xFilePick == null) return;
      return File(pickedFile!.path);
    } on PlatformException catch (e) {
      Log.error('Failed to pick video: $e');
    }
  }

  static Future<void> openVideoFileSelectorDialog({
    required BuildContext context,
    required Function(File? videoFile) onPicked,
  }) async {
    await DialogService.customDialog(
      context: context,
      title: "Choose a video from",
      dialogPosition: Alignment.bottomCenter,
      actions: [
        /// video from camera
        KOutlinedButton(
          onPressed: () async {
            final videoFile = await _pickVideoFile(source: ImageSource.camera);
            if (videoFile != null) {
              Get.back();
              if (videoFile is File) {
                onPicked(videoFile);
              }
            }
          },
          width: MediaQuery.of(context).size.width * 0.4,
          borderColor: kPrimaryColor,
          bgColor: kWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt,
                color: kPrimaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Camera',
                style: context.titleMedium(),
              ),
            ],
          ),
        ),

        /// video from gallery
        KOutlinedButton(
          onPressed: () async {
            final videoFile = await _pickVideoFile(source: ImageSource.gallery);
            if (videoFile != null) {
              Get.back();
              if (videoFile is File) {
                onPicked(videoFile);
              }
            }
          },
          width: MediaQuery.of(context).size.width * 0.4,
          borderColor: kPrimaryColor,
          bgColor: kWhite,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.image,
                color: kPrimaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Gallery',
                style: context.titleMedium(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
