import 'package:safepak/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.name,
    super.email,
    super.uid,
    super.phoneNumber,
    super.imageUrl,
    super.dob,
    super.province,
    super.address,
    super.city,
    super.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      uid: json['uid'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      dob: json['dob'] ?? '',
      province: json['province'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'dob': dob,
      'province': province,
      'city': city,
      'address': address,
      'gender':gender
    };
  }

  factory UserModel.fromEntity(UserEntity user){
    return UserModel(
      name: user.name,
      email: user.email,
      uid: user.uid,
      phoneNumber: user.phoneNumber,
      imageUrl: user.imageUrl,
      dob: user.dob,
      province: user.province,
      address: user.address,
      city: user.city,
      gender: user.gender,
    );
  }
}
