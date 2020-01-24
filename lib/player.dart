
import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  Player({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
      ),
      child: Slider(
      min: 0.0,
      max: widget.duration.inMilliseconds.toDouble(),
      value: _dragValue ?? widget.position.inMilliseconds.toDouble(),
      onChanged: (value) {
        setState(() {
          _dragValue = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged(Duration(milliseconds: value.round()));
        }
      },
      onChangeEnd: (value) {
        _dragValue = null;
        if (widget.onChangeEnd != null) {
          widget.onChangeEnd(Duration(milliseconds: value.round()));
        }
      },
    ) ,
    ); 
  }
  //volume, speed adjust
        // Text("Volume"),
        // StreamBuilder<double>(
        //   stream: _volumeSubject.stream,
        //   builder: (context, snapshot) => Slider(
        //     divisions: 20,
        //     min: 0.0,
        //     max: 2.0,
        //     value: snapshot.data ?? 1.0,
        //     onChanged: (value) {
        //       _volumeSubject.add(value);
        //       _player.setVolume(value);
        //     },
        //   ),
        // ),
        // Text("Speed"),
        // StreamBuilder<double>(
        //   stream: _speedSubject.stream,
        //   builder: (context, snapshot) => Slider(
        //     divisions: 10,
        //     min: 0.5,
        //     max: 1.5,
        //     value: snapshot.data ?? 1.0,
        //     onChanged: (value) {
        //       _speedSubject.add(value);
        //       _player.setSpeed(value);
        //     },
        //   ),
        // ),
}