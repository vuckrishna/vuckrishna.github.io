class UserModel {
  static UserModel _instance = UserModel._internal();

  String? id;
  String? name;
  String? username;
  String? email;
  String? role;
  String? accState;
  String? photourl;
  String? residency;
  String? verifyDocumentID;
  List<dynamic>? favourites;
  List<dynamic>? articles;
  List<dynamic>? planner;

  factory UserModel() {
    return _instance;
  }

  UserModel._internal();

  UserModel.fromJson(this.id, Map<String, dynamic> json)
      : name = json['name'],
        username = json["username"],
        email = json['email'],
        role = json["role"],
        accState = json['accState'],
        favourites = json['favourites'],
        articles = json['articles'],
        
        planner = json['planner'],
        photourl = json['photourl'],
        residency = json['residency'],
        verifyDocumentID = json['verifyDocumentID'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'role': role,
        'accState': accState,
        'favourites': favourites,
        'articles': articles,
        'planner': planner,
        'photourl': photourl,
        'residency': residency,
        'verifyDocumentID': verifyDocumentID,
      };

  static UserModel getUser() {
    return _instance;
  }

  static void setUser(UserModel obj) {
    _instance = obj;
  }
}
