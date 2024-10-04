import 'dart:convert';

import 'package:flutter/foundation.dart';

class EstateModel {
  final String name;
  final List<String> fileLinks;
  final String description;
  final String featuredImage;
  final String quarter;
  final String location;
  final int price;
  EstateModel({
    required this.name,
    required this.fileLinks,
    required this.description,
    required this.featuredImage,
    required this.quarter,
    required this.location,
    required this.price,
  });

  EstateModel copyWith({
    String? name,
    List<String>? fileLinks,
    String? description,
    String? featuredImage,
    String? quarter,
    String? location,
    int? price,
  }) {
    return EstateModel(
      name: name ?? this.name,
      fileLinks: fileLinks ?? this.fileLinks,
      description: description ?? this.description,
      featuredImage: featuredImage ?? this.featuredImage,
      quarter: quarter ?? this.quarter,
      location: location ?? this.location,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'fileLinks': fileLinks,
      'description': description,
      'featuredImage': featuredImage,
      'quarter': quarter,
      'location': location,
      'price': price,
    };
  }

  factory EstateModel.fromMap(Map<String, dynamic> map) {
    return EstateModel(
      name: map['name'] ?? '',
      fileLinks: List<String>.from(map['fileLinks']),
      description: map['description'] ?? '',
      featuredImage: map['featuredImage'] ?? '',
      quarter: map['quarter'] ?? '',
      location: map['location'] ?? '',
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstateModel.fromJson(String source) => EstateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EstateModel(name: $name, fileLinks: $fileLinks, description: $description, featuredImage: $featuredImage, quarter: $quarter, location: $location, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EstateModel &&
        other.name == name &&
        listEquals(other.fileLinks, fileLinks) &&
        other.description == description &&
        other.featuredImage == featuredImage &&
        other.quarter == quarter &&
        other.location == location &&
        other.price == price;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        fileLinks.hashCode ^
        description.hashCode ^
        featuredImage.hashCode ^
        quarter.hashCode ^
        location.hashCode ^
        price.hashCode;
  }
}
