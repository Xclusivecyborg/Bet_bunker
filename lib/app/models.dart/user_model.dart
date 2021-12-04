class Users {
  final String? userName;
  final String? photoUrl;
  final String? userId;
  final String? email;
  final String? createdAt;
  final String? aboutMe;
  final bool? loggedIn;

  Users(
      {this.userName,
      this.photoUrl,
      this.userId,
      this.email,
      this.createdAt,
      this.aboutMe,
      this.loggedIn});

  factory Users.fromMap(json) {
    return Users(
      userName: json['userName'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['createdAt'] ?? '',
      aboutMe: json['aboutMe'] ?? '',
      loggedIn: json['loggedIn'] ?? '',
    );
  }

  static Map<String, dynamic> toFireStore({
    String? userName,
    String? photoUrl,
    String? userId,
    String? email,
    String? createdAt,
    String? aboutMe,
    bool? loggedIn,
  }) {
    return {
      'userName': userName,
      'photoUrl': photoUrl,
      'userId': userId,
      'email': email,
      'createdAt': createdAt,
      'aboutMe': aboutMe,
      'loggedIn': loggedIn
    };
  }

  @override
  String toString() {
    return 'userName: $userName, photoUrl: $photoUrl, userId: $userId, email: $email, createdAt: $createdAt, aboutMe: $aboutMe, loggedIn: $loggedIn';
  }
}
