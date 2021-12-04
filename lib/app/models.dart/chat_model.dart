class Chat {
  final String? chatRoomId;
  final String? sender;
  final DateTime? createdAt;
  final List<String>? users;

  Chat({this.chatRoomId, this.sender, this.createdAt, this.users});

  static Map<String, dynamic> toFireStore({
    String? chatRoomId,
    String? sender,
    DateTime? createdAt,
    List<String>? users,
  }) {
    return {
      'chatRoomId': chatRoomId,
      'sender': sender,
      'createdAt': createdAt,
      'users': users,
    };
  }
}
