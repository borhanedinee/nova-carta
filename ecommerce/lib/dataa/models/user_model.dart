class User {
  final int id;
  final String username;
  final String password;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String avatar;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.token,
  });

  // Factory method to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdat']),
      updatedAt: DateTime.parse(json['updatedat']),
      avatar: json['avatar'],
      token: json['token'],
    );
  }

  // Method to convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'createdat': createdAt.toIso8601String(),
      'updatedat': updatedAt.toIso8601String(),
      'avatar': avatar,
      'token': token,
    };
  }
}
