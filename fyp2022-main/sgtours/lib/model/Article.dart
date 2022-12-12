class Article {
  static Article? _instance;

  String? id;
  String author;
  String authorId;
  String dateCreated;
  String title;
  String content;
  String? imageUrl;
  String artState;

  Article({
    this.id,
    required this.author,
    required this.authorId,
    required this.dateCreated,
    required this.title,
    required this.content,
    required this.artState,
  });

  factory Article.init(String id, Map<String, dynamic> json) {
    _instance = Article(
      id: id,
      author: json['author'],
      authorId: json['authorId'],
      dateCreated: json['dateCreated'],
      title: json['title'],
      content: json['content'],
      artState: json['artState'],
    );

    return _instance!;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "author": author,
      "authorId": authorId,
      "dateCreated": dateCreated,
      "title": title,
      "content": content,
      "imageUrl": imageUrl,
      "artState": artState,
    };
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        "author": author,
        "authorId": authorId,
        "dateCreated": dateCreated,
        "title": title,
        "content": content,
        "imageUrl": imageUrl,
        "artState": artState,
      };

  static Article getArticle() {
    return _instance!;
  }
}
