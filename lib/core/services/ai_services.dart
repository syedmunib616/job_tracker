import 'package:dio/dio.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  final Dio _dio = Dio();

  // final String _apiKey = "AIzaSyAX_tqcsqS85IfYMmRxWcYXSu3silEy6qM";
  final String _apiKey = "AIzaSyCYXQjM-Ooh4-hzjnOen6_pWNUWmS4utyQ";
  Future<String> generateResponse(String prompt) async {

    try {

      final model = GenerativeModel(

        model: 'gemini-3.1-flash-lite-preview',
        // model: 'gemini-1.5-flash',
        apiKey: _apiKey,
      );

      final response = await model.generateContent([
        Content.text(prompt),
      ]);
      print("${response.text}");
      return response.text ?? "No response";

    } catch (e) {
      print("AI ERROR: $e");
      return "Error generating response";
    }

  }

  // Future<String> generateResponse(String prompt) async {
  //   try {
  //     final response = await _dio.post(
  //       "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent",
  //       queryParameters: {
  //         "key": _apiKey,
  //       },
  //       data: {
  //         "contents": [
  //           {
  //             "parts": [
  //               {"text": prompt}
  //             ]
  //           }
  //         ]
  //       },
  //     );
  //
  //
  //     final data = response.data;
  //
  //     return data["candidates"][0]["content"]["parts"][0]["text"];
  //   } catch (e) {
  //     print("::::: $e");
  //     return "Error generating response";
  //   }
  // }
}