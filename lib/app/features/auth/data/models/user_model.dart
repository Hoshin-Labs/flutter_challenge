import 'package:todo_app/app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.uid,
    super.email,
    super.password,
    super.displayName,
    super.age,
    super.isVerified,
  });

}
