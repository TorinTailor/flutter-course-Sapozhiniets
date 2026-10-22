import 'package:flutter/material.dart';

import '../../domain/entities/game.dart';

class CategoryStyle {
  final String label;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final IconData icon;

  const CategoryStyle({
    required this.label,
    required this.color,
    required this.borderColor,
    required this.textColor,
    required this.icon,
  });
}

extension GameCategoryStyle on GameCategory {
  CategoryStyle get style => switch (this) {
    GameCategory.empty => const CategoryStyle(
      label: '- empty -',
      color: Color(0xFFB0B0B0),
      borderColor: Color(0xFF282828),
      textColor: Color(0xFF000000),
      icon: Icons.person,
    ),
    GameCategory.action => const CategoryStyle(
      label: 'Экшен',
      color: Color(0xFFF0B3B3),
      borderColor: Color(0xFFD14A4A),
      textColor: Color(0xFF8B1A1A),
      icon: Icons.flash_on,
    ),
    GameCategory.automation => const CategoryStyle(
      label: 'Автоматизация',
      color: Color(0xFFF5C99B),
      borderColor: Color(0xFFD18A3E),
      textColor: Color(0xFF7A4410),
      icon: Icons.settings_suggest,
    ),
    GameCategory.deepStory => const CategoryStyle(
      label: 'Глубокий сюжет',
      color: Color(0xFFC9B3F0),
      borderColor: Color(0xFF8A5CD1),
      textColor: Color(0xFF4A1A8B),
      icon: Icons.auto_stories,
    ),
    GameCategory.factoryBuilding => const CategoryStyle(
      label: 'Строительство фабрики',
      color: Color(0xFFD8C4A8),
      borderColor: Color(0xFFA8885A),
      textColor: Color(0xFF6B4A1A),
      icon: Icons.factory,
    ),
    GameCategory.choicesMatter => const CategoryStyle(
      label: 'Решения с последствиями',
      color: Color(0xFFA8DDE0),
      borderColor: Color(0xFF3EA8B0),
      textColor: Color(0xFF10565C),
      icon: Icons.alt_route,
    ),
    GameCategory.openWorld => const CategoryStyle(
      label: 'Открытый мир',
      color: Color(0xFF88CF8E),
      borderColor: Color(0xFF4FAE27),
      textColor: Color(0xFF297137),
      icon: Icons.public,
    ),
    GameCategory.rpg => const CategoryStyle(
      label: 'Ролевая игра',
      color: Color(0xFFD5B3F0),
      borderColor: Color(0xFF9A5CD1),
      textColor: Color(0xFF5A2A8B),
      icon: Icons.shield,
    ),
    GameCategory.simulator => const CategoryStyle(
      label: 'Симулятор',
      color: Color(0xFFF0DDA3),
      borderColor: Color(0xFFD1B24A),
      textColor: Color(0xFF8B6A1A),
      icon: Icons.build,
    ),
    GameCategory.slasher => const CategoryStyle(
      label: 'Слэшер',
      color: Color(0xFFF0A8A8),
      borderColor: Color(0xFFC43E3E),
      textColor: Color(0xFF7A1010),
      icon: Icons.sports_martial_arts,
    ),
    GameCategory.space => const CategoryStyle(
      label: 'Космос',
      color: Color(0xFF9CC5F0),
      borderColor: Color(0xFF3E7FD1),
      textColor: Color(0xFF1A4C8B),
      icon: Icons.rocket_launch,
    ),
  };
}

Color colorFromHex(String hex) => Color(int.parse('FF$hex', radix: 16));
