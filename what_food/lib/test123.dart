import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:what_food/Models/UserModel.dart';
import 'package:what_food/Models/post.dart';
import 'package:what_food/Services/AuthService.dart';

class ProfileScreen extends StatefulWidget {
  final String currentUserId;
  final String userId;

  ProfileScreen({this.currentUserId, this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //bool _isFollowing = false;
  int _followerCount = 0;
  int _followingCount = 0;
  int _displayPosts = 0; // 0 - grid, 1 - column
  //User _profileUser;
  List<Post> _posts = [];

  Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = AuthService.profile_Author();
    //_setupProfileUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '                                            IT    Social',
          style: TextStyle(
            fontFamily: 'Avengeance',
            fontSize: 25.0,
            color: Colors.red,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: AuthService.logout_Author,
          ),
        ],
      ),
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.grey,
                        backgroundImage: snapshot.data.avatar.isEmpty
                            ? AssetImage('assets/Avatar_default.jpg')
                            : CachedNetworkImageProvider(snapshot.data.avatar),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      _posts.length.toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Posts',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      _followerCount.toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Followers',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      _followingCount.toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Following',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        snapshot.data.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Divider(),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
