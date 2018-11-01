import 'package:login_app/src/data/database_helper.dart';
import 'package:login_app/src/data/rest_ds.dart';
import 'package:login_app/src/models/auth.dart';

abstract class LoginScreenContract {
  void onLoginSuccess();
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestDatasource api = new RestDatasource();
  LoginScreenPresenter(this._view);

  doLogin(String email, String password) {
    api.login(email, password).then((Auth auth) {
      print("API login");
      var db = new DatabaseHelper();
      db.saveAuth(auth).then((_) {
        _view.onLoginSuccess();
      });
    }, onError: (e) {
      handleError(e);
    }).catchError(handleError);
  }

  handleError(Exception error) {
    _view.onLoginError(error.toString());
  }
}
