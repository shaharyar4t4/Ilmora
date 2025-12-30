import 'package:flutter/material.dart';
import 'package:ilmora/model/qari.dart';
import 'package:ilmora/model/surah.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({
    super.key,
    required this.qari,
    required this.index,
    required this.list,
  });

  final Qari qari;
  final int index;
  final List<Surah>? list;

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> with WidgetsBindingObserver {
  final AudioPlayer _player = AudioPlayer();

  int currentIndex = 0;
  String? formattedIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    currentIndex = widget.index - 1;
    _loadAndPlay(currentIndex);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.pause();
    }
  }

  String _formatIndex(int index) {
    if (index < 10) return "00$index";
    if (index < 100) return "0$index";
    return index.toString();
  }

  Future<void> _loadAndPlay(int index) async {
    final surahNumber = widget.list![index].number ?? 1;
    final formattedIndex = _formatIndex(surahNumber);

    final url =
        "https://download.quranicaudio.com/quran/${widget.qari.path}$formattedIndex.mp3";

    debugPrint("AUDIO URL => $url");

    try {
      await _player.setUrl(url);
      _player.play();
    } catch (e) {
      debugPrint("Audio load error: $e");
    }
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, buffered, duration) =>
            PositionData(position, buffered, duration ?? Duration.zero),
      );

  void playNext() {
    if (currentIndex < widget.list!.length - 1) {
      currentIndex++;
      _loadAndPlay(currentIndex);
    }
  }

  void playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      _loadAndPlay(currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final surah = widget.list![currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text(surah.englishName ?? ""), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              surah.englishName ?? "",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Text(
              "Total Ayah: ${surah.numberofAyahs}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            StreamBuilder<PositionData>(
              stream: positionDataStream,
              builder: (context, snapshot) {
                final data = snapshot.data;
                return Column(
                  children: [
                    Slider(
                      min: 0,
                      max: data?.duration.inSeconds.toDouble() ?? 0,
                      value: data?.position.inSeconds.toDouble() ?? 0,
                      onChanged: (value) {
                        _player.seek(Duration(seconds: value.toInt()));
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(data?.position ?? Duration.zero)),
                        Text(_formatDuration(data?.duration ?? Duration.zero)),
                      ],
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            /// ▶ controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.skip_previous),
                  onPressed: playPrevious,
                ),
                const SizedBox(width: 20),

                StreamBuilder<PlayerState>(
                  stream: _player.playerStateStream,
                  builder: (context, snapshot) {
                    final playing = snapshot.data?.playing ?? false;
                    return IconButton(
                      iconSize: 60,
                      icon: Icon(
                        playing ? Icons.pause_circle : Icons.play_circle,
                      ),
                      onPressed: () {
                        playing ? _player.pause() : _player.play();
                      },
                    );
                  },
                ),

                const SizedBox(width: 20),
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.skip_next),
                  onPressed: playNext,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
