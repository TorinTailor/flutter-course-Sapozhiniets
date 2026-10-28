import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/foundation.dart';

enum GameCategory {
  empty,
  action,
  automation,
  deepStory,
  factoryBuilding,
  choicesMatter,
  openWorld,
  rpg,
  simulator,
  slasher,
  space;
}

class Game {
  final String id;
  //final String userId;
  final String title;
  final String subtitle;
  final Set<GameCategory> categories;
  final String imageAsset;
  final String accentColor;

  const Game({
    required this.id,
    //required this.userId,
    required this.title,
    required this.subtitle,
    required this.categories,
    required this.imageAsset,
    required this.accentColor,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as String,
      //userId: json['userId'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      categories: (json['category'] as List<dynamic>)
          .map((value) => GameCategory.values.byName(value as String))
          .toSet(),
      imageAsset: json['image'] as String,
      accentColor: json['accentColor'] as String,
    );
  }

factory Game.fromFirestore(
  DocumentSnapshot<Map<String, dynamic>> doc,
) {
  final data = doc.data()!;

  return Game(
    id: doc.id,
    title: data['title'] as String? ?? '',
    subtitle: data['subtitle'] as String? ?? '',
    categories: (data['category'] as List<dynamic>? ?? [])
        .map(
          (value) => GameCategory.values.byName(
            value as String? ?? '',
          ),
        )
        .toSet(),
    imageAsset: data['image'] as String? ?? '',
    accentColor: data['accentColor'] as String? ?? '',
  );
}

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'category': categories.map((category) => category.name).toList(),
      'image': imageAsset,
      'accentColor': accentColor,
    };
  }
}
