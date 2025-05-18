import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? imageUrl;
  final String? dob;
  final String? province;
  final String? address;
  final String? city;
  final String? gender;
  
  // Just to store the image temporarily
  final File? image;

  const UserEntity({
    this.dob,
    this.province,
    this.address,
    this.city,
    this.gender,
    this.uid,
    this.email,
    this.name,
    this.phoneNumber,
    this.imageUrl,
    this.image,
  });

  UserEntity copyWith({
    String? uid,
    String? email,
    String? name,
    String? phoneNumber,
    String? imageUrl,
    String? dob,
    String? province,
    String? address,
    String? city,
    String? gender,
    File? image,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      dob: dob ?? this.dob,
      province: province ?? this.province,
      address: address ?? this.address,
      city: city ?? this.city,
      gender: gender ?? this.gender,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [uid, email, name, phoneNumber, imageUrl, image, dob, province, address, city, gender];
}
