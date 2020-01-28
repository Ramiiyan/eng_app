
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RPlayer extends StatefulWidget {
  
  final String audioTitle;
  final String audioUrl;
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  RPlayer({
    @required this.audioTitle,
    @required this.audioUrl,
    this.duration,
    this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<RPlayer> {
  AudioPlayer _player;
  double _dragValue;
  
  @override
  void initState(){
    super.initState();
    _player = AudioPlayer();
    _player.setUrl(widget.audioUrl);

  }
  @override
  void dispose(){
    _player.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return _audioCard();
  }

  Widget _audioCard(){
    return  StreamBuilder<AudioPlaybackState>(
      stream: _player.playbackStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:ListTile( 
               leading: _playOrPause(state,_player),
              title: Text(widget.audioTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0),
              ),
              subtitle: StreamBuilder<Duration>(
                stream: _player.durationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  return StreamBuilder<Duration>(
                    stream: _player.getPositionStream(),
                    builder: (context, snapshot) {
                      var position = snapshot.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }
                      return _seekbar(
                        duration, 
                        position,
                        (newPosition) {
                          _player.seek(newPosition);
                        }
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _playOrPause( AudioPlaybackState state, AudioPlayer _player){
    if (state == AudioPlaybackState.playing)
      return IconButton(
        icon: Icon(Icons.pause_circle_outline),
        iconSize: 40.0,
        color: Colors.blue,
        onPressed: _player.pause,
      );
    else if (state == AudioPlaybackState.buffering || state == AudioPlaybackState.connecting)
      return Container(
        margin: EdgeInsets.all(4.0),
        width: 38.0,
        height: 38.0,
        child: CircularProgressIndicator(),
      );
    else                      
      return IconButton(
        icon: Icon(Icons.play_circle_outline),
        iconSize: 40.0,
        onPressed: _player.play,
      );
      // IconButton(
      //   icon: Icon(Icons.stop),
      //   iconSize: 64.0,
      //   onPressed: state == AudioPlaybackState.stopped ||
      //           state == AudioPlaybackState.none
      //       ? null
      //       : _player.stop,
      // ),
  }

  Widget _seekbar(Duration duration, Duration position,ValueChanged<Duration> onChangeEnd){
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
      ),
      child: Slider(
        min: 0.0,
        max: duration.inMilliseconds.toDouble(),
        value: _dragValue ?? position.inMilliseconds.toDouble(),
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
      ),
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