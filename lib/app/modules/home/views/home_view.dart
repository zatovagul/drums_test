import 'package:audioplayers/audioplayers.dart';
import 'package:drums_test/app/services/audio_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Drums Test'),
        centerTitle: true,
      ),
      body: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController controller;
  late AudioService audioService;
  Map<String, AudioPlayer> sounds={};
  bool start=false, metronom=false, stringSound=false;

  @override
  void initState() {
    controller=TextEditingController(text: "120");
    audioService = AudioService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getButton(
            () {
              if(!start)
              setState((){
                metronom=!metronom;
              });
            },
            Text("!._.!._.", style: _style,),
            BoxDecoration(color: metronom ? Colors.green : Colors.white)
          ),
          SizedBox(height: 15,),
          getButton(
                () {
                  if(!start)
                  setState(() {
                    stringSound=!stringSound;
                  });
                },
              Text("BBT_BBT_", style: _style,),
              BoxDecoration(color: stringSound ? Colors.green : Colors.white)
          ), SizedBox(height: 15,),
          Container(
            height: 40,
            width: Get.width/1.5,
            decoration: BoxDecoration(color: Colors.white),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
            ),
          ),SizedBox(height: 15,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getSoundButton("B", (){audioService.playBas();}),SizedBox(width: 10,),
                getSoundButton("T", (){audioService.playTon();}),SizedBox(width: 10,),
                getSoundButton("S", (){audioService.playSlap();}),
              ],
            ),
          ),
          SizedBox(height: 15,),
          getButton(
                () {
                  if(!start)_setStart(true);
                  },
            Text("Старт", style: _style,),
            BoxDecoration(color: start ? Colors.green : Colors.white)
          ),
          SizedBox(height: 15,),
          getButton(
                () {if(start)_setStart(false);},
            Text("Стоп", style: _style,),
              BoxDecoration(color:!start ? Colors.red : Colors.white)
          ),
        ],
      ),
    );
  }

  Widget getButton(onPressed, child, [decoration]) {
    return Container(
      height: 40,
      width: Get.width / 1.5,
      decoration: decoration==null ? BoxDecoration(color: Colors.white) : decoration,
      child: TextButton(onPressed: onPressed, child: child),
    );
  }

  Widget getSoundButton(String s, onTap){
    return Container(
      color: Colors.white,
      height: 80,
      width: 80,
      child: Material(
        child: InkWell(
          enableFeedback: false,
          splashColor: Colors.brown,
          onTap: onTap,
          child: Center(child: Text(s, style: _style.copyWith(fontSize: 30),)),
        ),
      ),
    );
  }

  TextStyle get _style=>TextStyle(fontSize: 20, color: Colors.black);


  _setStart(a){
    setState(() {
      start=a;
    });
    if(a){
      if(stringSound)
      _playString("BBT_BBT_");
      if(metronom)
      _playString("!._.!._.");

      if(!stringSound && !metronom)
        _setStart(false);
    }
    else{
      audioService.stringPause=true;
    }
  }
  _playString(String s) async{
    int a = int.parse((1000/(int.parse(controller.text)/60)).toStringAsFixed(0));
    while(start){
      await audioService.playString(s, duration: a);
    }
  }
}
