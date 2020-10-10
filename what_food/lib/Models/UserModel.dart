class User {
  String id;
  String email;
  String phone;
  String password;
  String name;
  String avatar;
  String bio;
//Constructor
  User(
      {this.id, this.email, this.phone, this.name, this.password, this.avatar, this.bio});
//Create Static Method
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["_id"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        password: json["password"],
        avatar: json["avatar"],
        bio: json["bio"]
    );
  }
}
