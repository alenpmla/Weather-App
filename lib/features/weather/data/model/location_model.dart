import '../../domain/entities/location.dart';

class LocationModel {
  String? title;
  String? locationType;
  int? woeId;
  String? lattLong;

  LocationModel({this.title, this.locationType, this.woeId, this.lattLong});

  LocationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    locationType = json['location_type'];
    woeId = json['woeid'];
    lattLong = json['latt_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['location_type'] = locationType;
    data['woeid'] = woeId;
    data['latt_long'] = lattLong;
    return data;
  }

  Location toLocation() {
    return Location(woeId: woeId, title: title);
  }
}
