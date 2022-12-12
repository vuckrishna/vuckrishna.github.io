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

class Thread {
  static Thread? _instance;

  String? id;
  String author;
  String authorId;
  String lastUpdated;
  String dateCreated;
  String title;
  String description;
  List<String> commentIds;

  Thread({
    this.id,
    required this.author,
    required this.authorId,
    required this.lastUpdated,
    required this.dateCreated,
    required this.title,
    required this.description,
    required this.commentIds,
  });

  factory Thread.init(String id, Map<String, dynamic> json) {
    _instance = Thread(
        id: id,
        author: json['author'],
        authorId: json['authorId'],
        lastUpdated: json['lastUpdated'],
        dateCreated: json['dateCreated'],
        title: json['title'],
        description: json['description'],
        commentIds: List.from(json['commentIds']));

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
    };
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'authorId': authorId,
        'lastUpdated': lastUpdated,
        'title': title,
        'commentIds': commentIds
      };

  static Thread getThread() {
    return _instance!;
  }
}
