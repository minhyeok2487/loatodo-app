import 'dart:convert';

import 'package:loatodo_app/models/characters/character_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CharacterApi {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get token => dotenv.env['API_TOKEN'] ?? '';

  static Future<List<CharacterModel>> getCharacterList() async {
    List<CharacterModel> characterList = [];
    final url = Uri.parse('$baseUrl/api/v1/character-list');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> characters =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var character in characters) {
        characterList.add(CharacterModel.fromJson(character));
      }
      return characterList;
    }

    // 에러 처리를 좀 더 구체적으로
    if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid token');
    } else if (response.statusCode == 403) {
      throw Exception('Forbidden: Insufficient permissions');
    }
    throw Exception('Failed to load characters: ${response.statusCode}');
  }
}
