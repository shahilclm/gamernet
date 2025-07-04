class Post {
  final String id;
  final String userId;
  final String imageUrl;
  final String content;
  final DateTime timestamp;

  Post(
      {required this.id,
      required this.userId,
      required this.imageUrl,
      required this.content,
      required this.timestamp});

  //convert post to map for firebase

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'imageUrl': imageUrl,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  //create post from firbase document

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        id: map['id'],
        userId: map['userId'],
        imageUrl: map['imageUrl'],
        content: map['content'],
        timestamp: DateTime.parse(map['timestamp']));
  }
}
