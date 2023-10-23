// ignore_for_file: file_names

class UsersModel {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic shop;
  dynamic address;
  dynamic phone;
  dynamic password;
  dynamic image;
  // type user if 1 admin if 2 user if 3 registeration request if 4 stop
  dynamic typeuser;

  UsersModel(
      {this.id,
      this.name,
      this.shop,
      this.address,
      this.email,
      this.phone,
      this.password,
      this.image,
      this.typeuser});

  UsersModel.fromJson(Map<String, dynamic> map) {
    id = map['usr_id'];
    name = map['usr_name'];
    shop = map['usr_shop'];
    address = map['usr_address'];
    email = map['usr_email'];
    phone = map['usr_phone'];
    password = map['usr_password'];
    image = map['usr_image'];
    typeuser = map['usr_type'] ?? 2;
  }
  Map<String, dynamic> toJson() {
    return {
      "usr_name": name,
      "usr_shop": shop,
      "usr_address": address,
      "usr_email": email,
      "usr_phone": phone,
      "usr_password": password,
      "usr_image": image,
      "usr_type": typeuser,
    };
  }
}
