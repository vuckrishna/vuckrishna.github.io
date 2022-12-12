import 'dart:ffi';

class VerifyLol {
  static VerifyLol? _instance;

  String? id;
  String fullLegalName;
  String handle;
  String imageurl;

  VerifyLol({
    this.id,
    required this.fullLegalName,
    required this.handle,
    required this.imageurl,
  });

  factory VerifyLol.init(String id, Map<String, dynamic> json) {
    _instance = VerifyLol(
        id: id,
        fullLegalName: json['fullLegalName'],
        handle: json['handle'],
        imageurl: json['imageurl'],
        );

    return _instance!;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "fullLegalName": fullLegalName,
      "handle": handle,
      "imageurl": imageurl,
    };
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        "fullLegalName": fullLegalName,
      "handle": handle,
      "imageurl": imageurl,
      };

  static VerifyLol getVerifyLol() {
    return _instance!;
  }
}
