import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const StopwatchApp());

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color pastelPink = Color(0xFFFFC1E3);
    const Color pastelPurple = Color(0xFFE1D7FF);
    const Color pastelYellow = Color(0xFFFFF5C3);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stopwatch App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: pastelPurple,
        scaffoldBackgroundColor: pastelYellow,
        appBarTheme: const AppBarTheme(
          backgroundColor: pastelPink,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 56, fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(fontSize: 18),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: pastelPink,
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const StopwatchPage(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});
  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;

  String _mainTime = '00:00.00';
  final List<String> _laps = [];
  bool get _isRunning => _stopwatch.isRunning;

  void _startOrResume() {
    _stopwatch.start();
    _ticker ??= Timer.periodic(const Duration(milliseconds: 30), _updateClock);
    setState(() {});
  }

  void _pause() {
    _stopwatch.stop();
    setState(() {});
  }

  void _reset() {
    _stopwatch
      ..reset()
      ..stop();
    _ticker?.cancel();
    _ticker = null;
    _laps.clear();
    _mainTime = '00:00.00';
    setState(() {});
  }

  void _addLap() {
    setState(() => _laps.insert(0, _mainTime));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Tură salvată!')));
  }

  void _updateClock(Timer timer) {
    final e =
        _stopwatch
            .elapsed; //e, timpul scurs de la pornirea cronometrului (de tip Duration)
    final minutes = e.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = e.inSeconds.remainder(60).toString().padLeft(2, '0');
    final centis = (e.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(
      2,
      '0',
    );
    setState(() => _mainTime = '$minutes:$seconds.$centis');
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch App')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(_mainTime, style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isRunning
                    ? ElevatedButton.icon(
                      onPressed: _pause,
                      icon: const Icon(Icons.pause),
                      label: const Text('Pause'),
                    )
                    : ElevatedButton.icon(
                      onPressed: _startOrResume,
                      icon: const Icon(Icons.play_arrow),
                      label: Text(_laps.isEmpty ? 'Start' : 'Resume'),
                    ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _isRunning ? _addLap : null,
                  icon: const Icon(Icons.flag),
                  label: const Text('Lap'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.restore),
                  label: const Text('Reset'),
                ),
                const SizedBox(width: 30),
                Text(
                  'Ture: ${_laps.length}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child:
                  _laps.isEmpty
                      ? const Center(child: Text('Nicio tura inca.'))
                      : ListView.builder(
                        itemCount: _laps.length,
                        itemBuilder: (context, index) {
                          final reversedIndex = _laps.length - index;
                          final bgColor =
                              index.isEven
                                  ? const Color(0xFFE1D7FF)
                                  : const Color(0xFFFFC1E3);
                          return Card(
                            color: bgColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: ListTile(
                              leading: Text('#$reversedIndex'),
                              title: Text(_laps[index]),
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
