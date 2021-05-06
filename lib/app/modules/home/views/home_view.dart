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
            () {print("fuck");},
            Text("!._.!._.", style: _style,),
          ),
          SizedBox(height: 15,),
          getButton(
                () {print("fuck");},
            Text("BBT_BBT_", style: _style,),
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
            child: Center(
              child: Container(
                color: Colors.white,
                height: 80, width: 80,
                child: TextButton(
                  onPressed: (){
                    audioService.playBas();
                  },
                  child: Text("B", style: _style.copyWith(fontSize: 30),),
                ),
              ),
            ),
          ),
          SizedBox(height: 15,),
          getButton(
                () {},
            Text("Старт", style: _style,),
            BoxDecoration(color: Colors.white)
          ),
          SizedBox(height: 15,),
          getButton(
                () {},
            Text("Стоп", style: _style,),
              BoxDecoration(color: Colors.green)
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

  TextStyle get _style=>TextStyle(fontSize: 20, color: Colors.black);
}
