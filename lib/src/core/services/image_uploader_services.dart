import 'dart:convert';
import 'dart:io';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class ImageUploaderServices {
  static Future<String?> uploadImageToServer(String imageFile) async {
    try {
      dynamic responseBody = await Network.handleResponse(
        await Network.multipartAddRequest(
          api: "https://api.imgbb.com/1/upload?key=5f70c81026c22affdeb17a02a337f3d2",
          body: {},
          fileKeyNames: ['image'],
          filePaths: [imageFile],
        ),
      );

      if (responseBody != null) {
        return responseBody['data']['url'];
      }
      return null;
    } catch (e) {
      Log.error('Error uploading image: $e');
      throw Exception('Error uploading image');
    }
  }
}
