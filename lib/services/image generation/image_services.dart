import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ImageServices {
  //generate image using dalle API
  final apiKey = dotenv.env['REPLICANTAPI'] ?? "";
  Future<String> dalleImageGenerater(String promte) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.replicate.com/v1/predictions"),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "version":
              "6f7a773af6fc3e8de9d5a3c00be77c17308914bf67772726aff83496ba1e3bbe",
          "input": {"prompt": promte}
        }),
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
