import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:todo_app/app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  final database = FirebaseDatabase.instance;

  @override
  Future<UserEntity?> retrieveCurrentUser() async {
    return auth.currentUser?.uid == 'uid' || auth.currentUser?.uid == null
        ? null
        : UserEntity(
            uid: auth.currentUser?.uid,
            email: auth.currentUser?.email,
            displayName: auth.currentUser?.displayName,
            isVerified: auth.currentUser?.emailVerified,
          );
  }

  @override
  Future<UserCredential?> register(String email, String password) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<UserCredential?> login(String email, String password) async {
    try {
      final userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    return auth.signOut();
  }

  @override
  Future<void> sendNotification(String message) async {
    await database.ref('users/${auth.currentUser!.uid}/').once().then((value) async {
      try {
        final dio = Dio();
        dio.options.headers['Content-Type'] = 'application/json';
        dio.options.headers['Authorization'] =
            'key=AAAAHsaSRF8:APA91bHWiYVMvAMUbNJNkfbuesrIi5PiYfJ74nV73Vb_h-yb1aBr-5d5ub48d67r3T_GcdXPgk_sAGA4-OcAJbTWsTCUzDHMXHLxOpnddfdGRxei_Czo1nWKd1460P4EDZB31ORownE5';
        final params = {
          'notification': {
            'title': 'Todo App',
            'body': message,
          },
          'priority': 'high',
          'to': value.snapshot.child('token').value.toString(),
        };
        await dio.post<dynamic>(
          'https://fcm.googleapis.com/fcm/send',
          data: jsonEncode(params),
        );
      } catch (e) {
        log('$e');
      }
    });
  }
}
