/*
  Auth Repository - outlines the  possible auth operations for this app
                    (not actually implemented here)
*/

import 'package:social_media/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<AppUser?> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<AppUser?> logout();
  Future<AppUser?>getCurrentUser();
}