import 'package:just_audio/just_audio.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final _player = AudioPlayer();

  void pauseAmbient() {
    _player.pause();
  }

  void resumeAmbient() {
    if (_player.processingState == ProcessingState.ready) {
      _player.play();
    }
  }
}
