import 'dart:convert';

import 'package:eng_app/rplayer.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  // final _volumeSubject = BehaviorSubject.seeded(1.0);
  // final _speedSubject = BehaviorSubject.seeded(1.0);
  // AudioPlayer _player, _player2, _player3;
  var url = "https://absolutezerolabs.com/api/v1/lessons/1";
  
  // @override
  // void initState() {
  //   super.initState();
  //   _player = AudioPlayer();
  //   _player2 = AudioPlayer();
  //   _player3 = AudioPlayer();
    
  //   _player.setUrl("http://www.freshly-ground.com/misc/music/20060826%20-%20Armstrong.mp3");
  //   _player2.setUrl("https://www2.iis.fraunhofer.de/AAC/ChID-BLITS-EBU-Narration441-16b.wav");
  //   // _player3.setUrl("https://absolutezerolabs.com/storage/H0OlYKonkIccUKjatQ0U.mp3");
  
  //   response();

  // }
  
  // @override
  // void dispose() {
  //   _player.dispose();
  //   _player2.dispose();
  //   _player3.dispose();
  //   super.dispose();
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          // _audioCard(),
          RPlayer(
            audioTitle: "Title 1",
            audioUrl: "https://www2.iis.fraunhofer.de/AAC/ChID-BLITS-EBU-Narration441-16b.wav",
          ),
          // _audioplayer(_player),
          // _audioCard(_player2),
          // _audioCard(_player3),
        ],
      ),
    );
  }
}
