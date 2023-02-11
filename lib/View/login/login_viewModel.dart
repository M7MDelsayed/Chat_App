import 'package:chat_app/DataBase/my_database.dart';
import 'package:chat_app/View/login/login_navigator.dart';
import 'package:chat_app/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Base/base_viewModel.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var authService = FirebaseAuth.instance;

  void login(String email, String password) async {
    navigator?.showLoading('Loading...');
    try {
      var credentials = await authService.signInWithEmailAndPassword(
          email: email, password: password);
      var retrievedUser =
          await MyDataBase.getUserFromFireStore(credentials.user?.uid ?? '');
      navigator?.hideLoading();
      if (retrievedUser == null) {
        navigator?.showMessage(
            'Something Went Wrong . Wrong UserName Or Password', 'Try Again',
            () {
          navigator?.hideLoading();
        });
      } else {
        SharedData.user = retrievedUser;
        navigator?.goToHome();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator?.hideLoading();
        navigator?.showMessage('No user found for that email.', 'OK', () {
          navigator?.hideLoading();
        });
      } else if (e.code == 'wrong-password') {
        navigator?.hideLoading();
        navigator?.showMessage('Wrong password provided for that user.', 'OK',
            () {
          navigator?.hideLoading();
        });
      }
    }
  }

  void checkLoggedUser() async {
    if (authService.currentUser != null) {
      var retrievedUser = await MyDataBase.getUserFromFireStore(
          authService.currentUser?.uid ?? '');
      SharedData.user = retrievedUser;
      navigator?.goToHome();
    }
  }
}
