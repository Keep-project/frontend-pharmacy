import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class Utility {
  static String base64String(File imageFile) {
    var imageBytes = imageFile.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }
}
