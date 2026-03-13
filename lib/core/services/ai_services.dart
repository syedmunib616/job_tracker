import 'package:dio/dio.dart';

class AIService {
  final Dio _dio = Dio();



  Future<String> generateResponse(String prompt) async {
    try {
      final response = await _dio.post(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent",
        queryParameters: {
          "key": _apiKey,
        },
        data: {
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        },
      );


      final data = response.data;

      return data["candidates"][0]["content"]["parts"][0]["text"];
    } catch (e) {
      print("::::: $e");
      return "Error generating response";
    }
  }
}