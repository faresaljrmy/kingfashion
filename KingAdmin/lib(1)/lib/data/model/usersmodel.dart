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
  // type user if 0 signup customer if 1 admin if 2 customer if 3 signup admin if 4 stop
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
    id = map['id'];
    name = map['name'];
    shop = map['shop'];
    address = map['address'];
    email = map['email'];
    phone = map['phone'];
    password = map['password'];
    image = map['image'];
    typeuser = map['type'] ?? 2;
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
