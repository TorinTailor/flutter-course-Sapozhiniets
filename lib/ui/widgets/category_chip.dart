import 'package:flutter/material.dart';
import '../../domain/entities/game.dart';
import 'game_category_style.dart';

class CategoryChip extends StatelessWidget {
  final GameCategory category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final style = category.style;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: style.color,
        border: Border.all(color: style.borderColor, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(style.icon, size: 14, color: style.textColor),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              style.label,
              style: TextStyle(color: style.textColor, fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
