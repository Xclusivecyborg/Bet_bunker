import 'package:cloud_firestore/cloud_firestore.dart';

class BetPosts {
  final String? id;
  final String? createdBy;
  final String? body;
  final String? photoUrl;
  final String? createdAt;

  BetPosts({this.id, this.createdBy, this.body, this.photoUrl, this.createdAt});

   factory BetPosts.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return BetPosts(
      id: json['id'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      createdBy: json['createdBy'] ?? '',
      body: json['body'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  @override
  String toString() {
    return 'id: $id, photoUrl: $photoUrl, body: $body, createdBy: $createdBy, createdAt: $createdAt,';
  }
}
