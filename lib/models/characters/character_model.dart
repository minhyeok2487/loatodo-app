import 'package:loatodo_app/models/day_content.dart';

class CharacterModel {
  final num characterId;
  final String characterClassName;
  final String characterImage;
  final String characterName;
  final double itemLevel;
  final String? memo;
  final String serverName;
  final int sortNumber;

  final DayContent chaos;
  final int chaosCheck;
  final int chaosGauge;
  final double chaosGold;

  CharacterModel.fromJson(Map<String, dynamic> json)
      : characterId = json['characterId'],
        characterClassName = json['characterClassName'],
        characterImage = json['characterImage'],
        characterName = json['characterName'],
        itemLevel = json['itemLevel'],
        memo = json['memo'],
        serverName = json['serverName'],
        sortNumber = json['sortNumber'],
        chaos = DayContent.fromJson(json['chaos']),
        chaosCheck = json['chaosCheck'],
        chaosGauge = json['chaosGauge'],
        chaosGold = json['chaosGold'];
}
