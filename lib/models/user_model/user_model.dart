class UserModel {
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? image;
  String? bio;
  String? status;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
    this.image,
    this.bio,
    this.status,
  });

  UserModel.fromJson(Map<String , dynamic >? json) {
    this.name = json!['name'];
    this.phone = json['phone'];
    this.email = json['email'];
    this.uId = json['uId'];
    this.image = json['image'];
    this.bio = json['bio'];
    this.status = json['status'];
  }

  Map<String , dynamic> toMap(){
    return {
      'name' : name,
      'phone' : phone,
      'email' : email,
      'uId' : uId,
      'image' : image,
      'bio' : bio,
      'status' : status,
    };
  }
}
