import 'package:cloud_firestore/cloud_firestore.dart';

class BetPosts {
  final String? createdBy;
  final String? body;
  final String? photoUrl;
  final Timestamp? createdAt;
  final String? id;
  final String? sentBy;

  BetPosts( 
      {this.id,this.sentBy, this.createdBy, this.body, this.photoUrl, this.createdAt});

  factory BetPosts.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return BetPosts(
      id: json.id,
      photoUrl: json ['photoUrl'] ?? '',
      createdBy: json['createdBy'] ?? '',
      body: json['body'] ?? '',
      createdAt: json['createdAt'] ?? '',
      sentBy: json['sentBy'] ?? '',
    );
  }

  static Map<String, dynamic> toFireStore({
    String? createdBy,
    String? body,
    String? photoUrl,
    DateTime? createdAt,
    String? sentBy,
  }) {
    return {
      'createdBy': createdBy,
      'createdAt': createdAt,
      'body': body,
      'photoUrl': photoUrl,
      'sentBy': sentBy,
    };
  }

  @override
  String toString() {
    return ' photoUrl: $photoUrl, body: $body, createdBy: $createdBy, createdAt: $createdAt,';
  }
}
