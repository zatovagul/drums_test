import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioService{
  static AudioCache cache=AudioCache();
  bool stringPause=false;
  Map<String, AudioPlayer> sounds={};

  playBas(){
    playSound("bas", "sounds/bas.wav");
  }
  playTon() {
    playSound("ton", "sounds/ton.wav");
  }
  playSlap() {
    playSound("slap", "sounds/slap.mp3");
  }

  playMetroSil(){
    playSound("metro_sil", "sounds/metro_sil.mp3");
  }
  playMetroSla(){
    playSound("metro_sla", "sounds/metro_sla.mp3");
  }

  playSound(key, url) async{
    if(sounds.containsKey(key)) {
      sounds[key]!.stop();
      sounds[key]!.resume();
    } else {
      AudioPlayer player = await cache.play(url);
      if(!sounds.containsKey(key)){
        sounds[key]=player;
      }
    }
  }

  Future<dynamic> playString(String s, {int duration:500}) async {
    stringPause=false;
    for(int i=0;i<s.length;i++){
      var sou=s[i];
      if(sou=="B")
        playBas();
      if(sou=="T")
        playTon();
      if(sou=="S")
        playSlap();
      if(sou=="!")
        playMetroSil();
      if(sou==".")
        playMetroSla();
      await Future.delayed(Duration(milliseconds: duration));
      if(stringPause)
        break;
    }
    return true;
  }
}