import 'Data.dart';

class Rest{
  final Data data;

  Rest({this.data});

  factory Rest.fromJson(Map<String, dynamic> json) {
    return Rest(
      data: Data.fromJson(json['data']),
    );
  }
  @override
  String toString() {
    
    return "data : [$data ]";
  }
}