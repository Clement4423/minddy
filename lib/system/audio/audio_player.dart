import 'package:audioplayers/audioplayers.dart';

class AppAudioPlayer {
  static final _player = AudioPlayer();

  static void play(String assetPath, {double? volume}) async {
    try {
      await _player.play(AssetSource(assetPath), volume: volume);
    } catch(e) {
      return;
    }
  }
}