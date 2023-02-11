import 'package:chat_app/Base/base_viewModel.dart';
import 'package:chat_app/DataBase/my_database.dart';
import 'package:chat_app/Model/my_user.dart';
import 'package:chat_app/View/create_account/register_navigator.dart';
import 'package:chat_app/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var authService = FirebaseAuth.instance;

  void register(
      {required String email,
      required String password,
      required String fullName,
      required String userName}) async {
    navigator?.showLoading('Loading...');
    try {
      var credentials = await authService.createUserWithEmailAndPassword(
          email: email, password: password);
      MyUser user = MyUser(
          id: credentials.user?.uid,
          fullName: fullName,
          userName: userName,
          email: email);
      var insertedUser = await MyDataBase.addUserToFirebaseFireStore(user);
      navigator?.hideLoading();
      if (insertedUser != null) {
        SharedData.user = insertedUser;
        navigator?.goToHome();
      } else {
        navigator?.showMessage(
            'Something Went Wrong .Error With Database', 'Try Again', () {
          navigator?.hideLoading();
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator?.hideLoading();
        navigator?.showMessage('The password provided is too weak.', 'OK', () {
          navigator?.hideLoading();
        });
      } else if (e.code == 'email-already-in-use') {
        navigator?.hideLoading();
        navigator?.showMessage(
            'The account already exists for that email.', 'OK', () {
          navigator?.hideLoading();
        });
      }
    } catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage('Something Went Wrong', 'OK', () {});
    }
  }
}
