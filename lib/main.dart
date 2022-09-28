import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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

  void jumpToSdwebimage() async{

    Navigator.push(context, CupertinoPageRoute(builder: (v){return FirstPage();}));

  }
  void jumpToNetworkimage() async{

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: (){
              jumpToSdwebimage();
            }, child: Text("sdwebimage")),
            TextButton(onPressed: (){
              jumpToNetworkimage();
            }, child: Text("cached_network_image")),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: list.length,
            //     itemBuilder: (context ,index){
            //       getTextureId(index);
            //       return Container(
            //         width: 400,
            //         height: 400,
            //         color: Colors.yellow,
            //         margin: const EdgeInsets.only(top: 20),
            //         child:map[index] == null || map[index] == -1 ? Container(): Texture(textureId: map[index] ?? -1),
            //       );
            //       },
            //   ),
            // ),
            // textureId != -1 ? Container(
            //   width: 300,
            //   height: 300,
            //   color: Colors.yellow,
            //   child: Texture(textureId: textureId),
            // ): Container()
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
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
