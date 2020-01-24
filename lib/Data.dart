//sub json Name is Data can't help

class Data {
  final String lesson;
  final String audio;

  Data({this.audio,this.lesson});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      lesson: json['lesson'],
      audio: json['audio'],
    );
  }
  @override
  String toString() {

    return "lesson : $lesson , audio : $audio";
  }
}