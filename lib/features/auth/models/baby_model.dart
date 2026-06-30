import 'package:equatable/equatable.dart';

class BabyModel extends Equatable {
  final String id;
  final String name;
  final String? gender;
  final String? birthDate;
  final String? weight;
  final bool isBorn;

  const BabyModel({
    required this.id,
    required this.name,
    this.gender,
    this.birthDate,
    this.weight,
    this.isBorn = true,
  });

  BabyModel copyWith({
    String? id,
    String? name,
    String? gender,
    String? birthDate,
    String? weight,
    bool? isBorn,
  }) {
    return BabyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      weight: weight ?? this.weight,
      isBorn: isBorn ?? this.isBorn,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'gender': gender,
    'birthDate': birthDate,
    'weight': weight,
    'isBorn': isBorn,
  };

  factory BabyModel.fromMap(Map<String, dynamic> map) => BabyModel(
    id: map['id'] ?? '',
    name: map['name'] ?? 'নতুন বাবু',
    gender: map['gender'],
    birthDate: map['birthDate'],
    weight: map['weight'],
    isBorn: map['isBorn'] ?? true,
  );

  @override
  List<Object?> get props => [id, name, gender, birthDate, weight, isBorn];
}
