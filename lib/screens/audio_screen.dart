import 'package:flutter/material.dart';
import 'package:ilmora/model/qari.dart';
import 'package:ilmora/model/surah.dart';
import 'package:just_audio/just_audio.dart';

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

class _AudioScreenState extends State<AudioScreen> {
  final _player = AudioPlayer();
  bool isLoopingCurrentItem = false;
  Duration defaultDuration = Duration(milliseconds: 1);
  String? ind;
  int currentIndex = 0;
  int dataIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      currentIndex = widget.index - 1;
      dataIndex = widget.index - 1;
    });

    if (widget.index < 10) {
      ind = "00" + (widget.index.toString());
    } else if (widget.index < 100) {
      ind = "0" + (widget.index.toString());
    } else if (widget.index > 100) {
      ind = (widget.index.toString());
    }

    _initAudioPlayer(ind!, widget.qari);
    print('index ${widget.index} current Index ${currentIndex}');
    super.initState();
  }

  @override
  void dispose(){
    _player.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {}

  void handleLooping() async {}

  Stream<PositionData> get _positionDataStream =>  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Center(child: Text("Audio Screen"))),
    );
  }
}
