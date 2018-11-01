import 'package:login_app/src/models/blog.dart';
import 'package:flutter/material.dart';

class BlogPost extends StatelessWidget {
  BlogPost({this.blog, this.currentUserId, this.animationController});
  final Blog blog;
  final int currentUserId;

  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    if (currentUserId == blog.user.id) {
      return _buildRight(context);
    } else {
      return _build(context);
    }
  }

  Widget _build(BuildContext context) {
    var container = new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(blog.user.name[0])),
          ),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(blog.createdAt.toString(),
                    style: Theme.of(context).textTheme.caption),
                new Text(blog.user.name,
                    style: Theme.of(context).textTheme.title),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(blog.title),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    if (animationController != null) {
      return new SizeTransition(
          sizeFactor: new CurvedAnimation(
              parent: animationController, curve: Curves.easeOut),
          axisAlignment: 0.0,
          child: container);
    } else {
      return container;
    }
  }

  Widget _buildRight(BuildContext context) {
    var container = new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(blog.createdAt.toString(),
                  style: Theme.of(context).textTheme.caption),
              new Text(blog.user.name,
                  style: Theme.of(context).textTheme.title),
              new Container(
                margin: const EdgeInsets.only(top: 5.0, right: 4.0),
                child: new Text(blog.title),
              ),
            ],
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(right: 16.0, left: 2.0),
          child: new CircleAvatar(child: new Text(blog.user.name[0])),
        ),
      ],
    );

    if (animationController != null) {
      return new SizeTransition(
          sizeFactor: new CurvedAnimation(
              parent: animationController, curve: Curves.easeOut),
          axisAlignment: 0.0,
          child: new Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: container,
          ));
    } else {
      return container;
    }
  }
}
