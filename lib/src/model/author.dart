class Author {
  String email;
  String firstName;
  String lastName;
  String gender;
  String uuid;
  dynamic image;

  Author({
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.uuid,
    this.image,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        email: json["email"] == null ? null : json["email"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        gender: json["gender"] == null ? null : json["gender"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "gender": gender == null ? null : gender,
        "uuid": uuid == null ? null : uuid,
        "image": image,
      };
}
