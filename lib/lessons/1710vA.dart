import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: HomeScreen()));
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  String _mood = 'не выбрано';
  Future<void> _chooseMood() async {
    // TODO 2: откройте MoodScreen и дождитесь результата:
    //         final mood = await Navigator.push<String>(...);
    final mood = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MoodScreen()),
    );
    // TODO 3: если mood не null — сохраните его в _mood через setState
    //         (не забудьте: после await сначала if (!mounted) return;)
    if (!mounted) return;
    if (mood != null) {
      setState(() {
        _mood = mood;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настроение')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Сегодня: $_mood', style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 24),
            FilledButton(onPressed: _chooseMood, child: const Text('Выбрать')),
          ],
        ),
      ),
    );
  }
}
class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});
  static const moods = ['A', 'B', 'C', 'D', 'E'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Как дела?')),
      body: Center(
        child: Wrap(
          spacing: 16,
          children: [
            for (final mood in moods)
              InkWell(
                onTap: () {
                  // TODO 1: закройте экран и верните выбранный mood
                  Navigator.pop(context, mood);
                },
                child: Text(mood, style: const TextStyle(fontSize: 48)),
              ),
          ],
        ),
      ),
    );
  }
}