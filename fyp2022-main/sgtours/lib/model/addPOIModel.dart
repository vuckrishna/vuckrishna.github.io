class AddPOI {
  static AddPOI? _instance;

  String? id;
  String name;
  String address;
  String? description;
  double lat;
  double long;
  String website;
  String? photourl;
  String? placeid;

  AddPOI({
    this.id,
    required this.name,
    required this.address,
    this.description,
    required this.lat,
    required this.long,
    required this.website,
    this.photourl,
    this.placeid,
  });

  factory AddPOI.init(Map<String, dynamic> json) {
    _instance = AddPOI(
      // id: id,
      name: json['name'],
      address: json['formatted_address'],
      // description: json['description'],
      lat: json['geometry']['location']['lat'],
      long: json['geometry']['location']['lng'],
      website: json['website'],
      // photourl: json['photourl'],
      // placeid: json['placeid'],
    );

    return _instance!;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "address": address,
      "description": description,
      "lat": lat,
      "long": long,
      "website": website,
      "photourl": photourl,
      "placeid": placeid,
    };
  }

  factory AddPOI.fromJson(Map<String, dynamic> json) {
    return AddPOI(
      name: json['name'],
      address: json['formatted_address'],
      lat: json['geometry']['location']['lat'],
      long: json['geometry']['location']['lng'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'description': description,
        'lat': lat,
        'long': long,
        'website': website,
        'photourl': photourl,
        'placeid': placeid
      };

  static AddPOI getThread() {
    return _instance!;
  }
}
