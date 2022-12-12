import 'dart:ffi';

class ESfeedback {
  static ESfeedback? _instance;

  String? id;
  String feedbackState;
  String name;
  String email;
  String contact;
  String residency;
  String feedbacktype;
  String subject;
  String feedback;
  //List<String> commentIds;

  ESfeedback({
    this.id,
    required this.feedbackState,
    required this.name,
    required this.email,
    required this.contact,
    required this.residency,
    required this.feedbacktype,
    required this.subject,
    required this.feedback,

    //required this.commentIds,
  });

  factory ESfeedback.init(String id, Map<String, dynamic> json) {
    _instance = ESfeedback(
        id: id,
        feedbackState: json['feedbackState'],
        name: json['name'],
        email: json['email'],
        contact: json['contact'],
        residency: json['residency'],
        feedbacktype: json['feedbacktype'],
        subject: json['subject'],
        feedback: json['feedback'],

        //commentIds: List.from(json['commentIds'])
        );

    return _instance!;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "feedbackState": feedbackState,
      //"commentIds": commentIds,
      "email": email,
      "contact": contact,
      "residency": residency,
      "feedbacktype": feedbacktype,
      "subject": subject,
      "feedback": feedback,
    };
  }

  Map<String, dynamic> toJson() => {
        'id': id,
      "name": name,
      "feedbackState": feedbackState,
      //"commentIds": commentIds,
      "email": email,
      "contact": contact,
      "residency": residency,
      "feedbacktype": feedbacktype,
      "subject": subject,
      "feedback": feedback,
        //'commentIds': commentIds
      };

  static ESfeedback getESfeedback() {
    return _instance!;
  }
}
