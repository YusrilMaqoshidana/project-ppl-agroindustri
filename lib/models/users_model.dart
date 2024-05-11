// user.dart
class User {
  String uid;
  String email;
  String password;
  String name;

  User({
    required this.uid,
    required this.email,
    required this.password,
    required this.name,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        uid: data['uid'] as String,
        email: data['email'] as String,
        password: data['password'] as String,
        name: data['name'] as String,
      );

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'password': password,
        'name': name,
      };
}

