import 'package:login_app/src/data/database_helper.dart';
import 'package:login_app/src/data/rest_ds.dart';
import 'package:login_app/src/models/blog.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

abstract class BlogScreenContract {
  void onLoadBlogSuccess(ListBlog blogs);
  void onLoadBlogError(String errorMessage);
  void onLogoutSuccess();
}

class BlogScreenPresenter {
  BlogScreenContract _view;
  RestDatasource api = new RestDatasource();
  BlogScreenPresenter(this._view);
  int currentPage = 0;

  loadBlogs() {
    print('Loading: ${currentPage + 1}');

    api.getBlogs(currentPage + 1).then((ListBlog blogs) {
      if (currentPage < blogs.totalPages) {
        currentPage++;
      }

      updateBadger();
      _view.onLoadBlogSuccess(blogs);
    }).catchError(
        (Exception error) => _view.onLoadBlogError(error.toString()));
  }

  void logout() {
    api.logout().then((dynamic _) {
      var db = new DatabaseHelper();
      db.deleteDb().then((_) {
        _view.onLogoutSuccess();
      });
    });
  }

  void readAll() {
    api.readAll().then((dynamic _) {
      updateBadger();
    });
  }

  void updateBadger() {
    FlutterAppBadger.isAppBadgeSupported().then((isSupported) {
      if (isSupported) FlutterAppBadger.removeBadge();
      // FlutterAppBadger.updateBadgeCount(1);
    });
  }
}
