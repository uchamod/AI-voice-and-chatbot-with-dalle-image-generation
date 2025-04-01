import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ImageServices {
  //generate image using dalle API
  final apiKey = dotenv.env['DALLEAPIKEY'] ?? "";
  Future<String> dalleImageGenerater(String promte) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {"model": "dall-e-3", "prompt": promte, "n": 1, "size": "1024x1024"},
        ),
      );

      if (response.statusCode == 200) {
        String imageUrl = jsonDecode(response.body)["data"][0]["url"];
        imageUrl = imageUrl.trim();
        return imageUrl;
      } else {
        print("no fetched image${jsonDecode(response.body)}");
        return "";
      }
    } catch (err) {
      print("Internel server error $err");
      return "";
    }
  }
}
