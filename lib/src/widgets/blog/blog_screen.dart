import 'package:login_app/src/models/blog.dart';

import 'package:login_app/src/widgets/blog/blog_screen_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  BlogScreen({Key key}) : super(key: key);

  @override
  State createState() => new BlogScreenState();
}

class BlogScreenState extends State<BlogScreen>
    with TickerProviderStateMixin
    implements BlogScreenContract {
  final List<Blog> _blogs = <Blog>[];

  int currentUserId;

  BlogScreenPresenter _presenter;

  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  BlogScreenState() {
    _presenter = new BlogScreenPresenter(this);
  }

  void onLoadBlogSuccess(ListBlog listBlog) {}

  void onLoadBlogError(String errorMessage) {
    debugPrint(errorMessage);
  }

  void onLogoutSuccess() {
    Navigator.of(context).pushReplacementNamed("/login");
  }

  @override
  void initState() {
    super.initState();

    if (_blogs.length == 0) {
      _presenter.loadBlogs();
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  void _getMoreData() {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      _presenter.loadBlogs();
      setState(() {
        isPerformingRequest = false;
      });
    }
  }

  void logout() {
    _presenter.logout();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Room"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.exit_to_app),
            tooltip: 'Logout',
            onPressed: logout,
          )
        ],
      ),
      body: new Container(
          child: new Column(children: <Widget>[
            new Flexible(child: Text("Great")),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: null,
            ),
          ]),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))
              : null), //new
    );
  }
}
