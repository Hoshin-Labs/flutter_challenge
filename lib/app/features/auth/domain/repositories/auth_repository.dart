import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> retrieveCurrentUser();
  Future<UserCredential?> register(String email, String password);
  Future<UserCredential?> login(String email, String password);
  Future<void> signOut();
  Future<void> sendNotification(String message);
}
