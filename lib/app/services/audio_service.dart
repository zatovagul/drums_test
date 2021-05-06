import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioService{
  AudioCache cache=AudioCache();

  Future<AudioPlayer> playBas(){
    return cache.play("sounds/bas.wav");
  }
}