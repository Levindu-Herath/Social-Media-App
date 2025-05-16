import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/features/auth/domain/entities/app_user.dart';
import 'package:social_media/features/auth/domain/entities/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      //attempt sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // create user
      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: '');

      // return user
      return user;
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // attempt sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // create user
      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: name);

      // return user
      return user;
    } catch (e) {
      throw Exception('Error registering: $e');
    }
  }

  @override
  Future<AppUser?> logout()async {
   await firebaseAuth.signOut();
    
  }

  @override
  Future<AppUser?> getCurrentUser() async{
    try{
      // get currnt user
      final firebaseUser = firebaseAuth.currentUser;

      // check if user is null
      if (firebaseUser == null) {
        return null;
      }

      // user exists
      return AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: '',
      );
    }
    catch(e){
      throw Exception('Error getting current user: $e');
    }
   
  }
}
