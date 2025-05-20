import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "";
  static const String model = 'gemini-1.5-flash'; // or gemini-1.0-pro
  static const String endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey';

  Future<String> generateContent(String userPrompt) async {
    final Map<String, dynamic> body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": userPrompt}
          ]
        }
      ],
      "system_instruction": {
        "role": "system",
        "parts": [
          {
            "text":
                "You are a legal advisor and you only reply with respect to Pakistan Penal Code."
          }
        ]
      }
    };

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
      return text ?? "No response";
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to generate content: ${response.body}');
    }
  }
}
