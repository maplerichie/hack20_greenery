import 'dart:convert';

import 'address.dart';

class RequestItem {
  int id;
  String name;
  String description;
  Address address;
  int shipping; // 1-Delivery, 2-Pickup
  int category;
  String imageUrl;

  RequestItem({
    this.id,
    this.name,
    this.description,
    this.address,
    this.shipping,
    this.category,
    this.imageUrl,
  });

  RequestItem copyWith({
    int id,
    String name,
    String description,
    Address address,
    int shipping,
    int category,
    String imageUrl,
  }) {
    return RequestItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      shipping: shipping ?? this.shipping,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address?.toMap(),
      'shipping': shipping,
      'category': category,
      'imageUrl': imageUrl,
    };
  }

  static RequestItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RequestItem(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      address: Address.fromMap(map['address']),
      shipping: map['shipping'],
      category: map['category'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  static RequestItem fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'RequestItem(id: $id, name: $name, description: $description, address: $address, shipping: $shipping, category: $category, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RequestItem &&
        o.id == id &&
        o.name == name &&
        o.description == description &&
        o.address == address &&
        o.shipping == shipping &&
        o.category == category &&
        o.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        address.hashCode ^
        shipping.hashCode ^
        category.hashCode ^
        imageUrl.hashCode;
  }
}
