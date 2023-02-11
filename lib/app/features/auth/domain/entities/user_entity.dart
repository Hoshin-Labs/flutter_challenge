class UserEntity {
  UserEntity({
    this.uid,
    this.email,
    this.password,
    this.displayName,
    this.age,
    this.isVerified,
  });
  String? uid;
  bool? isVerified;
  final String? email;
  String? password;
  final String? displayName;
  final int? age;

  UserEntity copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? password,
    String? displayName,
    int? age,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
