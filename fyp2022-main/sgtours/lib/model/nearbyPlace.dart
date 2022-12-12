class NearbyPlace {
  final double lat;
  final double long;
  final String name;
  final String placeId;

  NearbyPlace(
      {required this.lat,
      required this.long,
      required this.name,
      required this.placeId});

  factory NearbyPlace.fromJson(Map<String, dynamic> json) {
    return NearbyPlace(
        lat: json["geometry"]["location"]["lat"],
        long: json["geometry"]["location"]["lat"],
        name: json["name"],
        placeId: json["place_id"]);
  }
  Map<String, dynamic> toJson() =>
      {'lat': lat, 'long': long, 'name': name, 'placeId': placeId};
}
