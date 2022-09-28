
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NetworkImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NetworkImagePageState();
  }

}

class NetworkImagePageState extends State<NetworkImagePage>{

  late MethodChannel methodChannel;

  Map<int , int> map = {};

  List<String> list = [
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966062162477056.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966342841106432.HEIC",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966500786012160.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966657288077312.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966824921825280.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023966927908765696.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1023967025740906496.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734365446537216.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734366658691072.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734370152546304.PNG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734378247553024.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734388653621248.HEIC",
    "http://static.awanptesting.com/impubnub-dev/chat-image/136_1021734517586526208.PNG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1021844119082762240.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1021844119053402112.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1021844119061790720.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1021844121423183872.JPG",
    "http://static.awanptesting.com/impubnub-dev/chat-image/139_1021844122756972544.JPG",

  ];

  int textureId = -1;

  void _incrementCounter() async{

    print("????");

    Navigator.push(context, CupertinoPageRoute(builder: (v){return NetworkImagePage();}));

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

                return Container(
                  width: 400,
                  height: 400,
                  color: Colors.yellow,
                  margin: const EdgeInsets.only(top: 20),
                  child:CachedNetworkImage(imageUrl: list[index] , width: 400,height: 400,)
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