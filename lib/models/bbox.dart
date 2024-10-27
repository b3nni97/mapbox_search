import 'package:json_annotation/json_annotation.dart';
import 'package:mapbox_search/models/location.dart';

class BBox {
  final Location min;
  final Location max;

  BBox({
    required this.min,
    required this.max,
  });

  String get asString => min.asString + ',' + max.asString;

  List<double> get asList => [
        ...min.asList,
        ...max.asList,
      ];

  factory BBox.fromList(List<double> list) => BBox(
        min: list.asLocation,
        max: list.sublist(2).asLocation,
      );
}

class BBoxConverter extends JsonConverter<BBox, List<dynamic>> {
  const BBoxConverter() : super();

  @override
  BBox fromJson(List<dynamic> json) {
    return BBox(
      min: (long: checkDouble(json[0]), lat: checkDouble(json[1])),
      max: (long: checkDouble(json[2]), lat: checkDouble(json[3])),
    );
  }

  @override
  List<double> toJson(BBox object) {
    return object.asList;
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return value.toDouble();
    } else {
      return value;
    }
  }
}
