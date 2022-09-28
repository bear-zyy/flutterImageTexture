
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FirstPageState();
  }

}

class FirstPageState extends State<FirstPage>{

  late MethodChannel methodChannel;

  Map<int , int> map = {};

  //进五次  内存到达630M  这有点夸张了
  //

  List<String> list = [
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966062162477056.JPG",////8M
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966342841106432.HEIC",//13.7M
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966500786012160.JPG",//4.8M
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966657288077312.JPG",//3.3
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966824921825280.JPG",//6.1
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966927908765696.JPG",//3.3
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023967025740906496.JPG",//2.2
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734365446537216.JPG",//1.7
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734366658691072.JPG",//0.476
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734370152546304.PNG",//0.292
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734378247553024.JPG",//8.6
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734388653621248.HEIC",//9.1
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734517586526208.PNG",//0.186
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1021844119082762240.JPG",//0.292
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1021844119053402112.JPG",//0.476
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1021844119061790720.JPG",//0.186
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1021844121423183872.JPG",//3.3
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1021844122756972544.JPG",//2.2

  ];

  int textureId = -1;

  void _incrementCounter() async{

    print("????");

    Navigator.push(context, CupertinoPageRoute(builder: (v){return FirstPage();}));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    methodChannel = const MethodChannel("ImageTexturePlugin");

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context ,index){
                getTextureId(index);
                return Container(
                  width: 400,
                  height: 400,
                  color: Colors.yellow,
                  margin: const EdgeInsets.only(top: 20),
                  child:map[index] == null || map[index] == -1 ? Container(): Texture(textureId: map[index] ?? -1),
                );
              },
            ),
          ),
          TextButton(onPressed: (){
            _incrementCounter();
          }, child: Container(height: 100,width: 200,color: Colors.red,)),

        ],
      ),
    );
  }

  getTextureId(int index)async{

    if(map[index] != null && map[index] != -1){
      return;
    }

    int a = await methodChannel.invokeMethod("showNativeImage" , {"url":list[index]});

    print("a == $a");
    map[index] = a;
    print("map == $map");

    setState((){});

  }


}