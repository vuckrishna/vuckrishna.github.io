class Planner {
  String? id;
  String date;
  String poi;

  Planner({
    this.id,
    required this.date,
    required this.poi,
  });

  factory Planner.init(String id, Map<String, dynamic> json) {
    return Planner(
      id: id,
      date: json['date'],
      poi: json['poi'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "date": date,
      "poi": poi,
    };
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'poi': poi,
      };
}
