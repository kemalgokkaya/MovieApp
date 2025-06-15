import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/repositories/auth_repository.dart';

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  Future<void> signInWithEmailAndPassword({
    required final email,
    required final password,
  }) async {
    return authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUpWithEmailAndPassword({
    required final email,
    required final password,
  }) async {
    return authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

final authControllerProvider = Provider(
  (ref) => AuthController(authRepository: ref.watch(authRepositoryProvider)),
);
