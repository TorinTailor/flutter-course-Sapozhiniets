import 'package:flutter/material.dart';

import '../../domain/entities/game.dart';
import '../widgets/game_card.dart';

const List<Game> _games = [
  Game(
    id: 1,
    title: "No Man's Sky",
    subtitle: 'Hello Games - 2016',
    categories: {
      GameCategory.space,
      GameCategory.openWorld,
      GameCategory.simulator,
    },
    imageAsset: 'assets/01.png',
    accentColor: Color(0xFF4FAE27),
  ),
  Game(
    id: 2,
    title: 'Factorio',
    subtitle: 'Wube Software STD - 2020',
    categories: {GameCategory.automation, GameCategory.factoryBuilding},
    imageAsset: 'assets/02.png',
    accentColor: Color(0xFF715731),
  ),
  Game(
    id: 3,
    title: 'Mass Effect™ Legendary Edition',
    subtitle: 'Elecronic Art - 2021',
    categories: {GameCategory.deepStory, GameCategory.rpg, GameCategory.space},
    imageAsset: 'assets/03.png',
    accentColor: Color(0xFF1E00C9),
  ),
  Game(
    id: 4,
    title: 'Darksiders III Deluxe Edition',
    subtitle: 'THQ Nordic - 2018',
    categories: {GameCategory.slasher, GameCategory.action},
    imageAsset: 'assets/05.png',
    accentColor: Color(0xFF321C09),
  ),
  Game(
    id: 5,
    title: 'Detroit: Become Human',
    subtitle: 'Quantic Dream - 2020',
    categories: {GameCategory.deepStory, GameCategory.choicesMatter},
    imageAsset: 'assets/06.png',
    accentColor: Color(0xFFC0B6F5),
  ),
  Game(
    id: 6,
    title: 'The Elder Scrolls V: Skyrim Special Edition',
    subtitle: 'Bethesda Softworks - 2016',
    categories: {GameCategory.openWorld, GameCategory.rpg},
    imageAsset: 'assets/07.png',
    accentColor: Color(0xFF000000),
  ),
  Game(
    id: 7,
    title: 'The Witcher 3: Wild Hunt — Remastered',
    subtitle: 'CD PROJEKT RED - 2015',
    categories: {
      GameCategory.openWorld,
      GameCategory.rpg,
      GameCategory.deepStory,
    },
    imageAsset: 'assets/04.png',
    accentColor: Color(0xFF3EBDEF),
  ),
  Game(
    id: 8,
    title: 'Kerbal Space Program: Complete Edition',
    subtitle: 'Private Division - 2015',
    categories: {GameCategory.space, GameCategory.simulator},
    imageAsset: 'assets/08.png',
    accentColor: Color(0xFF1F1748),
  ),
];

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final Set<int> _likedIds = {};
  bool _onlyFavorites = false;

  void _toggleLike(int id) {
    setState(() {
      if (_likedIds.contains(id)) {
        _likedIds.remove(id);
      } else {
        _likedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Game> visibleGames;
    if (_onlyFavorites) {
      visibleGames = _games.where((g) => _likedIds.contains(g.id)).toList();
    } else {
      visibleGames = _games;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFBF1DF),
      appBar: AppBar(
        toolbarHeight: 60,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Библиотека игр',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            Text(
              'В библиотеке игр: ${_games.length} \u00B7 В избранном: ${_likedIds.length}',
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  FilterChip(
                    showCheckmark: false,
                    avatar: _onlyFavorites
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border),
                    shape: StadiumBorder(),
                    label: const Text('Только избранные'),
                    labelStyle: TextStyle(
                      color: _onlyFavorites ? Colors.green : Colors.black87,
                    ),
                    selectedColor: const Color(0xFFB9CDBA),
                    side: BorderSide(
                      color: _onlyFavorites ? Color(0xFFB9CDBA) : Colors.grey,
                    ),
                    selected: _onlyFavorites,
                    onSelected: (v) => setState(() => _onlyFavorites = v),
                  ),
                ],
              ),
            ),
            Expanded(
              child: visibleGames.isEmpty
                  ? const Center(child: Text('Ничего не нашлось'))
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 15,
                        right: 15,
                        bottom: 15,
                      ),
                      itemCount: visibleGames.length,
                      itemBuilder: (context, index) {
                        final game = visibleGames[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GameCard(
                            game: game,
                            isLiked: _likedIds.contains(game.id),
                            onLikeTap: () => _toggleLike(game.id),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
