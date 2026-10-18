import 'package:flutter/material.dart';

enum GameCategory {
  action(
    label: 'Экшен',
    color: Color(0xFFF0B3B3),
    borderColor: Color(0xFFD14A4A),
    textColor: Color(0xFF8B1A1A),
    icon: Icons.flash_on,
  ),
  automation(
    label: 'Автоматизация',
    color: Color(0xFFF5C99B),
    borderColor: Color(0xFFD18A3E),
    textColor: Color(0xFF7A4410),
    icon: Icons.settings_suggest,
  ),
  deepStory(
    label: 'Глубокий сюжет',
    color: Color(0xFFC9B3F0),
    borderColor: Color(0xFF8A5CD1),
    textColor: Color(0xFF4A1A8B),
    icon: Icons.auto_stories,
  ),
  factoryBuilding(
    label: 'Строительство фабрики',
    color: Color(0xFFD8C4A8),
    borderColor: Color(0xFFA8885A),
    textColor: Color(0xFF6B4A1A),
    icon: Icons.factory,
  ),
  choicesMatter(
    label: 'Решения с последствиями',
    color: Color(0xFFA8DDE0),
    borderColor: Color(0xFF3EA8B0),
    textColor: Color(0xFF10565C),
    icon: Icons.alt_route,
  ),
  openWorld(
    label: 'Открытый мир',
    color: Color(0xFF88CF8E),
    borderColor: Color(0xFF4FAE27),
    textColor: Color(0xFF297137),
    icon: Icons.public,
  ),
  rpg(
    label: 'Ролевая игра',
    color: Color(0xFFD5B3F0),
    borderColor: Color(0xFF9A5CD1),
    textColor: Color(0xFF5A2A8B),
    icon: Icons.shield,
  ),
  simulator(
    label: 'Симулятор',
    color: Color(0xFFF0DDA3),
    borderColor: Color(0xFFD1B24A),
    textColor: Color(0xFF8B6A1A),
    icon: Icons.build,
  ),
  slasher(
    label: 'Слэшер',
    color: Color(0xFFF0A8A8),
    borderColor: Color(0xFFC43E3E),
    textColor: Color(0xFF7A1010),
    icon: Icons.sports_martial_arts,
  ),
  space(
    label: 'Космос',
    color: Color(0xFF9CC5F0),
    borderColor: Color(0xFF3E7FD1),
    textColor: Color(0xFF1A4C8B),
    icon: Icons.rocket_launch,
  );

  const GameCategory({
    required this.label,
    required this.color,
    required this.borderColor,
    required this.textColor,
    required this.icon,
    });

  final String label;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final IconData icon;
}

class Game {
  final int id;
  final String title;
  final String subtitle;
  final Set<GameCategory> categories;
  //final List<String> tags;
  final String imageAsset;
  final Color accentColor;
  //final Color imageBackgroundColor;
  final String? description;

  const Game({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.categories,
    //required this.tags,
    required this.imageAsset,
    required this.accentColor,
    //this.imageBackgroundColor = const Color(0xFF4FAE27),
    this.description,
  });
}
