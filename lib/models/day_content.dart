enum ContentCategory {
  chaosDungeon,
  guardianRaid,
  dailyEpona,
  legionRaid,
  abyssDungeon,
  abyssRaid,
  cubeOfEbony,
}

// 일일 컨텐츠 모델
class DayContent {
  final ContentCategory category;
  final double destructionStone;
  final double guardianStone;
  final double honorShard;
  final int id;
  final double jewelry;
  final double leapStone;
  final double level;
  final String name;
  final double shilling;

  // JSON 생성자
  DayContent.fromJson(Map<String, dynamic> json)
      : category = _parseCategory(json['category']),
        destructionStone = json['destructionStone'],
        guardianStone = json['guardianStone'],
        honorShard = json['honorShard'],
        id = json['id'],
        jewelry = json['jewelry'],
        leapStone = json['leapStone'],
        level = json['level'],
        name = json['name'],
        shilling = json['shilling'];

  // 한글 카테고리를 enum으로 변환
  static ContentCategory _parseCategory(String category) {
    switch (category) {
      case '카오스던전':
        return ContentCategory.chaosDungeon;
      case '가디언토벌':
        return ContentCategory.guardianRaid;
      case '일일에포나':
        return ContentCategory.dailyEpona;
      case '군단장레이드':
        return ContentCategory.legionRaid;
      case '어비스던전':
        return ContentCategory.abyssDungeon;
      case '어비스레이드':
        return ContentCategory.abyssRaid;
      case '에브니큐브':
        return ContentCategory.cubeOfEbony;
      default:
        return ContentCategory.chaosDungeon;
    }
  }
}
