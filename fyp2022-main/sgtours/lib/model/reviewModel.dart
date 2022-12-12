class Review {
  final String name;
  final String photourl;
  final String userurl;
  final int rating;
  final String content;
  final String relativetime;

  Review(
      {required this.name,
      required this.photourl,
      required this.userurl,
      required this.rating,
      required this.content,
      required this.relativetime});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        name: json['author_name'],
        photourl: json['profile_photo_url'],
        userurl: json['author_url'],
        rating: json['rating'],
        content: json['text'],
        relativetime: json['relative_time_description']);
  }

  // factory Review.fromJson(Map<String, dynamic> json){
  //   return (Review(
  //     name = json['author_name'],
  //   photourl = json['profile_photo_url'],
  //   userurl = json['author_url'],
  //   rating = json['rating'],
  //   content = json['text'],
  //   relativetime = json['relative_time_description']);)

  //   );

  // }

  Map<String, dynamic> toJson() => {
        'author_name': name,
        'profile_photo_url': photourl,
        'author_url': userurl,
        'rating': rating,
        'text': content,
        'relative_time_description': relativetime,
      };
}
