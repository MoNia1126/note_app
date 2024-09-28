class MyUser {
  static const String collectionName = 'users';
  String id;
  String userName;
  String email;
  String password;

  MyUser(
      {required this.id,
      required this.userName,
      required this.email,
      required this.password});

  MyUser.fromFireStore(Map<String, dynamic>? data)
      : this(
            id: data?['id'],
            userName: data?['userName'],
            email: data?['email'],
            password: data?['password']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'password': password
    };
  }
}
