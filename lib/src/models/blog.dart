import 'package:login_app/src/models/user.dart';

class Blog {
  int _id;  
  String _title;
  String _body;
  DateTime _createdAt;
  User _user;

  Blog.map(dynamic obj) {
    this._id = obj["id"];
    this._title = obj["title"];    
    this._body = obj["body"];
    this._user = new User.map(obj["user"]);
    this._createdAt = DateTime.tryParse(obj["created_at"]);
  }

  int get id => _id;
  String get title => _title;
  String get body => _body;
  DateTime get createdAt => _createdAt;
  User get user => _user;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = _title;
    map["body"] = _body;
    map["user"] = _user;
    map["created_at"] = _createdAt;

    return map;
  }
}

class ListBlog {
  int _currentPage;
  int _count;
  int _totalPages;
  int _totalCount;
  List<Blog> _blogs = <Blog>[];

  int get currentPpage => _currentPage;
  int get count => _count;
  int get totalPages => _totalPages;
  int get totalCount => _totalCount;
  List<Blog> get blogs => _blogs;

  ListBlog.map(dynamic obj) {
    this._currentPage = obj["current_page"];
    this._count = obj["count"];
    this._totalPages = obj["total_pages"];
    this._totalCount = obj["total_count"];

    for (final x in obj["blogs"]) {
      this._blogs.add(new Blog.map(x));
    }
  }
}
