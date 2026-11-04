import 'package:flutter/material.dart';

import '../../domain/entities/game.dart';
import '../../utils/connectivity.dart';
import '../../utils/error_messages.dart';
import '../widgets/error_banner.dart';
import '../widgets/game_category_style.dart';

const _accentColors = [
  '000000',
  'D14A4A',
  'D18A3E',
  '4FAE27',
  '3EA8B0',
  '3E7FD1',
  '8A5CD1',
];

const _defaultSubtitle = 'Добавлено пользователем. В состоянии модерации.';

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key});

  @override
  State<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final Set<GameCategory> _categories = {};
  String _accentColor = _accentColors.first;
  String? _titleError;
  bool _noInternet = false;

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      setState(() {
        _titleError = 'Введите название игры';
        _noInternet = false;
      });
      return;
    }

    if (!await hasInternet()) {
      if (!mounted) return;
      setState(() {
        _titleError = null;
        _noInternet = true;
      });
      return;
    }
    if (!mounted) return;

    final subtitle = _subtitleController.text.trim();

    Navigator.pop(
      context,
      Game(
        id: '',
        title: title,
        subtitle: subtitle.isEmpty ? _defaultSubtitle : subtitle,
        categories: _categories.isEmpty ? {GameCategory.empty} : _categories,
        imageAsset: 'assets/empty.png',
        accentColor: _accentColor,
      ),
    );
  }

  InputDecoration _decoration(String label, {String? errorText}) {
    OutlineInputBorder border() => OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFF6C4C1)),
      borderRadius: BorderRadius.circular(10),
    );

    return InputDecoration(
      labelText: label,
      errorText: errorText,
      border: border(),
      enabledBorder: border(),
      focusedBorder: border(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF1DF),
      appBar: AppBar(title: const Text('Новая игра')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_noInternet) ...[
              const ErrorBanner(noInternetActionMessage),
              const SizedBox(height: 16),
            ],
            TextField(
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: _decoration('Название *', errorText: _titleError),
              onChanged: (_) {
                if (_titleError != null) setState(() => _titleError = null);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _subtitleController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              decoration: _decoration('Издатель - год выпуска'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Категории',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final category in GameCategory.values.where(
                  (c) => c != GameCategory.empty,
                ))
                  _buildCategoryChip(category),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Цвет рамки обложки',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [for (final hex in _accentColors) _buildSwatch(hex)],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFB1B1),
                foregroundColor: const Color(0xFF5A0000),
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _submit,
              child: const Text(
                'Добавить игру',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(GameCategory category) {
    final style = category.style;
    final selected = _categories.contains(category);

    return FilterChip(
      avatar: Icon(style.icon, size: 16, color: style.textColor),
      label: Text(style.label),
      labelStyle: TextStyle(color: style.textColor, fontSize: 13),
      selected: selected,
      selectedColor: style.color,
      backgroundColor: Colors.white,
      side: BorderSide(color: style.borderColor),
      onSelected: (value) => setState(() {
        if (value) {
          _categories.add(category);
        } else {
          _categories.remove(category);
        }
      }),
    );
  }

  Widget _buildSwatch(String hex) {
    final selected = _accentColor == hex;

    return GestureDetector(
      onTap: () => setState(() => _accentColor = hex),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: colorFromHex(hex),
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: selected ? Colors.black87 : Colors.transparent,
          ),
        ),
        child: selected
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : null,
      ),
    );
  }
}
