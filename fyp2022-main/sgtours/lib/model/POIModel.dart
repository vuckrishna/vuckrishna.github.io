class POIModel {
  String? id;
  String name;
  String address;
  String placeid;
  String description;
  String website;
  String photourl;
  // String lowercasename;
  double lat;
  double long;

  POIModel({
    this.id,
    required this.name,
    required this.address,
    required this.placeid,
    required this.description,
    required this.website,
    required this.photourl,
    // required this.lowercasename,
    required this.lat,
    required this.long,
    
  });

  factory POIModel.init(String id, Map<String, dynamic> json) {
    return POIModel(
        id: id,
        name: json['name'],
        address: json['address'],
        placeid: json['placeid'],
        description: json['description'],
        website: json['website'],
        photourl: json['photourl'],
        // lowercasename: json['lowercasename'],
        lat: json['lat'],
        long: json['long'],
        );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "address": address,
      "placeid": placeid,
      "description": description,
      "website": website,
      "photourl": photourl,
      // "lowercasename": lowercasename,
      "lat": lat,
      "long": long,
    };
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
      "name": name,
      "address": address,
      "placeid": placeid,
      "description": description,
      "website": website,
      "photourl": photourl,
      // "lowercasename": lowercasename,
      "lat": lat,
      "long": long,
      };
}