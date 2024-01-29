class User {
  User({
    this.idUser,
    this.name,
    this.username,
    this.level,
    this.createdAt,
    this.updatedAt,
  });

  int? idUser;
  String? name;
  String? username;
  String? level;
  String? createdAt;
  String? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"] != null
            ? int.parse(json["id_user"].toString())
            : null,
        name: json["name"],
        username: json["username"],
        level: json["level"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "username": username,
        "level": level,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
