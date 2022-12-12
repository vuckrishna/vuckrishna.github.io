class AccRequests {
  String? id;
  String email;
  String name;
  String role;
  String username;
  String accState;
  String verifyDocumentID;

  AccRequests({
    this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.username,
    required this.accState,
    required this.verifyDocumentID,
  });

  factory AccRequests.init(String id, Map<String, dynamic> json) {
    return AccRequests(
      id: id,
      email: json['email'],
      name: json['name'],
      role: json['role'],
      username: json['username'],
      accState: json['accState'],
      verifyDocumentID: json['verifyDocumentID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "email": email,
      "name": name,
      "role": role,
      "username": username,
      "accState": accState,
      "verifyDocumentID": verifyDocumentID,
    };
  }

  Map<String, dynamic> toJson() => {'name': name};
}

class ArtRequests {
  String? id;
  String artState;
  String author;
  String authorId;
  String content;
  String dateCreated;
  String imageUrl;
  // String ownedBy;
  String title;

  ArtRequests({
    this.id,
    required this.artState,
    required this.author,
    required this.authorId,
    required this.content,
    required this.dateCreated,
    required this.imageUrl,
    // required this.ownedBy,
    required this.title,
  });

  factory ArtRequests.init(String id, Map<String, dynamic> json) {
    return ArtRequests(
      id: id,
      artState: json['artState'],
      author: json['author'],
      authorId: json['authorId'],
      content: json['content'],
      dateCreated: json['dateCreated'],
      imageUrl: json['imageUrl'],
      // ownedBy: json['ownedBy'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "artState": artState,
      "author": author,
      "authorId": authorId,
      "content": content,
      "dateCreated": dateCreated,
      "imageUrl": imageUrl,
      // "ownedBy": ownedBy,
      "title": title,
    };
  }

  Map<String, dynamic> toJson() => {
        // 'ownedBy': ownedBy
      };
}

class GuideRequests {
  String? id;
  String guideState;
  String author;
  String authorId;
  List<dynamic> commentIds;
  String dateCreated;
  String description;
  String lastUpdated;
  String title;
  String imageUrl;

  GuideRequests({
    this.id,
    required this.guideState,
    required this.author,
    required this.authorId,
    required this.commentIds,
    required this.dateCreated,
    required this.description,
    required this.lastUpdated,
    required this.title,
    required this.imageUrl,
  });

  factory GuideRequests.init(String id, Map<String, dynamic> json) {
    return GuideRequests(
      id: id,
      guideState: json['guideState'],
      author: json['author'],
      authorId: json['authorId'],
      commentIds: json['commentIds'],
      dateCreated: json['dateCreated'],
      description: json['description'],
      lastUpdated: json['lastUpdated'],
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "guideState": guideState,
      "author": author,
      "authorId": authorId,
      "commentIds": commentIds,
      "dateCreated": dateCreated,
      "description": description,
      "lastUpdated": lastUpdated,
      "title": title,
      "imageUrl": imageUrl,
    };
  }

  Map<String, dynamic> toJson() => {'guideState': guideState};
}

class LOLFullDetail {
  String? id;
  String fullLegalName;
  String handle;
  String imageUrl;

  LOLFullDetail({
    this.id,
    required this.fullLegalName,
    required this.handle,
    required this.imageUrl,
  });

  factory LOLFullDetail.init(String id, Map<String, dynamic> json) {
    return LOLFullDetail(
      id: id,
      fullLegalName: json['fullLegalName'],
      handle: json['handle'],
      imageUrl: json['imageurl'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "fullLegalName": fullLegalName,
      "handle": handle,
      "imageUrl": imageUrl,
    };
  }

  Map<String, dynamic> toJson() => {'fullLegalName': fullLegalName};
}

class BOFullDetail {
  String? id;
  String uen;
  String desc;
  String accState;
  String address;
  String email;
  String name;
  String nric;
  String role;
  String web;

  BOFullDetail({
    this.id,
    required this.uen,
    required this.desc,
    required this.accState,
    required this.address,
    required this.email,
    required this.name,
    required this.nric,
    required this.role,
    required this.web,
  });

  factory BOFullDetail.init(String id, Map<String, dynamic> json) {
    return BOFullDetail(
      id: id,
      uen: json['uen'],
      desc: json['desc'],
      accState: json['accState'],
      address: json['address'],
      email: json['email'],
      name: json['name'],
      nric: json['nric'],
      role: json['role'],
      web: json['web'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uen": uen,
      "desc": desc,
    };
  }

  Map<String, dynamic> toJson() => {'uen': uen};
}

/*
class ArticleRequests {
  String title;
  String author;

  ArticleRequests(this.title, this.author);
}

final List<ArticleRequests> articleRequests = [
  ArticleRequests('Welcome to Sentosa!', 'Sentosa Admin'),
  ArticleRequests('Welcome to USS!', 'USS Admin'),
  ArticleRequests('Enjoy a night stay at One Fullerton', 'John Tan'),
  ArticleRequests('How to spend a one day trip in Singapore like a tourist',
      'SingaporeInfluencer'),
];
*/
