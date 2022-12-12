class Comment {
  String? id;
  String userId;
  String username;
  String role;
  String comment;
  String dateCreated;

  Comment({
    this.id,
    required this.userId,
    required this.username,
    required this.role,
    required this.comment,
    required this.dateCreated,
  });

  factory Comment.init(String id, Map<String, dynamic> json) {
    return Comment(
        id: id,
        userId: json['userId'],
        username: json['username'],
        role: json['role'],
        comment: json['comment'],
        dateCreated: json['dateCreated']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "userId": userId,
      "username": username,
      "role": role,
      "comment": comment,
      "dateCreated": dateCreated
    };
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'userId': userId,
        'username': username,
        'role': role,
        'comment': comment,
        'dateCreated': dateCreated,
      };
}

class LolGuides {
  static LolGuides? _instance;

  String? id;
  String author;
  String authorId;
  String lastUpdated;
  String dateCreated;
  String title;
  String description;
  List<String> commentIds;
  String? imageUrl;
  String guideState;

  LolGuides({
    this.id,
    this.imageUrl,
    required this.author,
    required this.authorId,
    required this.lastUpdated,
    required this.dateCreated,
    required this.title,
    required this.description,
    required this.commentIds,
    required this.guideState,
  });

  factory LolGuides.init(String id, Map<String, dynamic> json) {
    _instance = LolGuides(
      id: id,
      imageUrl: json['imageUrl'],
      author: json['author'],
      authorId: json['authorId'],
      lastUpdated: json['lastUpdated'],
      dateCreated: json['dateCreated'],
      title: json['title'],
      description: json['description'],
      commentIds: List.from(json['commentIds']),
      guideState: json['guideState'],
    );

    return _instance!;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "author": author,
      "authorId": authorId,
      "commentIds": commentIds,
      "dateCreated": dateCreated,
      "description": description,
      "lastUpdated": lastUpdated,
      "title": title,
      "imageUrl": imageUrl,
      "guideState": guideState,
    };
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'authorId': authorId,
        'lastUpdated': lastUpdated,
        'title': title,
        'commentIds': commentIds,
        'imageUrl': imageUrl,
      };

  static LolGuides getLolGuide() {
    return _instance!;
  }
}

class Guides {
  static List<Guides> _instance = [];

  String id;
  String author;
  String authorId;
  List<String> guideIds;
  String? imageUrl = '';

  Guides({
    required this.id,
    required this.author,
    required this.authorId,
    required this.guideIds,
    this.imageUrl,
  });

  factory Guides.init(String id, Map<String, dynamic> json) {
    Guides guide = Guides(
        id: id,
        author: json['author'],
        authorId: json['authorId'],
        guideIds: List.from(json['guideIds']),
        imageUrl: json['imageUrl']);

    _instance.add(guide);
    return guide;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'authorId': authorId,
        'guideIds': guideIds,
        'imageUrl': imageUrl
      };

  static Guides getGuide(String val) {
    Guides returnVal = _instance[0];
    _instance.forEach((element) {
      if (element.authorId == val) returnVal = element;
    });
    return returnVal;
  }
}
