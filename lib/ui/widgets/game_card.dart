import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/game.dart';

import 'game_category_style.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final bool isLiked;
  final VoidCallback onLikeTap;

  const GameCard({
    super.key,
    required this.game,
    required this.isLiked,
    required this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 3,
                    color: colorFromHex(game.accentColor),
                  ),
                ),
                child: Image.asset(game.imageAsset),
              ),
              Positioned(
                right: 4,
                top: 5,
                child: InkWell(
                  onTap: onLikeTap,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: isLiked
                          ? const Color(0xFFFF0000)
                          : const Color(0xFF5F5F5F),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  game.title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(game.subtitle),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    for (final category in game.categories)
                      Builder(
                        builder: (context) {
                          final c = category.style;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: c.color,
                              border: Border.all(
                                color: c.borderColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(c.icon, size: 14, color: c.textColor),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    c.label,
                                    style: TextStyle(
                                      color: c.textColor,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
