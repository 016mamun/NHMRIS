import 'package:equatable/equatable.dart';
import 'baby_model.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final int pregnancyWeeks;
  final String? profileImage;
  final String? dob;
  final String? bloodGroup;
  final String? occupation;
  final String? addressHouseRoad;
  final String? addressArea;
  final String? addressPostOffice;
  final String? addressThana;
  final String? addressDistrict;
  final String? addressPostCode;
  final String? husbandName;
  final String? husbandOccupation;
  final String? husbandImage;
  final String? currentLocation;
  final String? regularResidence;
  final String? alternativePhone;
  final List<BabyModel> babies;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.pregnancyWeeks,
    this.profileImage,
    this.dob,
    this.bloodGroup,
    this.occupation,
    this.addressHouseRoad,
    this.addressArea,
    this.addressPostOffice,
    this.addressThana,
    this.addressDistrict,
    this.addressPostCode,
    this.husbandName,
    this.husbandOccupation,
    this.husbandImage,
    this.currentLocation,
    this.regularResidence,
    this.alternativePhone,
    this.babies = const [],
  });

  String get trimester {
    if (pregnancyWeeks <= 13) return '১ম ট্রাইমেস্টার চলছে';
    if (pregnancyWeeks <= 26) return '২য় ট্রাইমেস্টার চলছে';
    return '৩য় ট্রাইমেস্টার চলছে';
  }

  String get initials {
    final trimmed = name.trim();
    return trimmed.isNotEmpty ? trimmed[0] : 'ম';
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    int? pregnancyWeeks,
    String? profileImage,
    String? dob,
    String? bloodGroup,
    String? occupation,
    String? addressHouseRoad,
    String? addressArea,
    String? addressPostOffice,
    String? addressThana,
    String? addressDistrict,
    String? addressPostCode,
    String? husbandName,
    String? husbandOccupation,
    String? husbandImage,
    String? currentLocation,
    String? regularResidence,
    String? alternativePhone,
    List<BabyModel>? babies,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      pregnancyWeeks: pregnancyWeeks ?? this.pregnancyWeeks,
      profileImage: profileImage ?? this.profileImage,
      dob: dob ?? this.dob,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      occupation: occupation ?? this.occupation,
      addressHouseRoad: addressHouseRoad ?? this.addressHouseRoad,
      addressArea: addressArea ?? this.addressArea,
      addressPostOffice: addressPostOffice ?? this.addressPostOffice,
      addressThana: addressThana ?? this.addressThana,
      addressDistrict: addressDistrict ?? this.addressDistrict,
      addressPostCode: addressPostCode ?? this.addressPostCode,
      husbandName: husbandName ?? this.husbandName,
      husbandOccupation: husbandOccupation ?? this.husbandOccupation,
      husbandImage: husbandImage ?? this.husbandImage,
      currentLocation: currentLocation ?? this.currentLocation,
      regularResidence: regularResidence ?? this.regularResidence,
      alternativePhone: alternativePhone ?? this.alternativePhone,
      babies: babies ?? this.babies,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'phone': phone,
    'pregnancyWeeks': pregnancyWeeks,
    'profileImage': profileImage,
    'dob': dob,
    'bloodGroup': bloodGroup,
    'occupation': occupation,
    'addressHouseRoad': addressHouseRoad,
    'addressArea': addressArea,
    'addressPostOffice': addressPostOffice,
    'addressThana': addressThana,
    'addressDistrict': addressDistrict,
    'addressPostCode': addressPostCode,
    'husbandName': husbandName,
    'husbandOccupation': husbandOccupation,
    'husbandImage': husbandImage,
    'currentLocation': currentLocation,
    'regularResidence': regularResidence,
    'alternativePhone': alternativePhone,
    'babies': babies.map((b) => b.toMap()).toList(),
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    phone: map['phone'] ?? '',
    pregnancyWeeks: map['pregnancyWeeks'] ?? 0,
    profileImage: map['profileImage'],
    dob: map['dob'],
    bloodGroup: map['bloodGroup'],
    occupation: map['occupation'],
    addressHouseRoad: map['addressHouseRoad'],
    addressArea: map['addressArea'],
    addressPostOffice: map['addressPostOffice'],
    addressThana: map['addressThana'],
    addressDistrict: map['addressDistrict'],
    addressPostCode: map['addressPostCode'],
    husbandName: map['husbandName'],
    husbandOccupation: map['husbandOccupation'],
    husbandImage: map['husbandImage'],
    currentLocation: map['currentLocation'],
    regularResidence: map['regularResidence'],
    alternativePhone: map['alternativePhone'],
    babies: (map['babies'] as List<dynamic>?)?.map((b) => BabyModel.fromMap(Map<String, dynamic>.from(b))).toList() ?? [],
  );

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    pregnancyWeeks,
    profileImage,
    dob,
    bloodGroup,
    occupation,
    addressHouseRoad,
    addressArea,
    addressPostOffice,
    addressThana,
    addressDistrict,
    addressPostCode,
    husbandName,
    husbandOccupation,
    husbandImage,
    currentLocation,
    regularResidence,
    alternativePhone,
    babies,
  ];
}
