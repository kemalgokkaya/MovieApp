import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;

  AuthRepository({required this.firebaseFirestore, required this.auth});

  Future<void> signInWithEmailAndPassword({
    required dynamic email,
    required dynamic password,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithEmailAndPassword({
    required dynamic email,
    required dynamic password,
  }) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firebaseFirestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);
