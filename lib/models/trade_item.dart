import 'dart:convert';

import 'address.dart';
import 'user.dart';

const List TRADE_TYPE = ['Trade', 'Barter', 'Free Hug'];

class TradeItem {
  int id;
  String name;
  String description;
  Address address;
  int shipping; // 1-Delivery, 2-Pickup, 3-COD
  double shippingCost;
  int tradeType; // 1-Trade, 2-Barter, 3-Free Hug
  double price;
  String tradeFor;
  String tradeForDescription;
  String imageUrl;
  DateTime postedDate;
  User owner;

  TradeItem({
    this.id,
    this.name,
    this.description,
    this.address,
    this.shipping,
    this.shippingCost,
    this.tradeType,
    this.price,
    this.tradeFor,
    this.tradeForDescription,
    this.imageUrl,
    this.postedDate,
    this.owner,
  });

  TradeItem copyWith({
    int id,
    String name,
    String description,
    Address address,
    int shipping,
    double shippingCost,
    int tradeType,
    double price,
    String tradeFor,
    String tradeForDescription,
    String imageUrl,
    DateTime postedDate,
    User owner,
  }) {
    return TradeItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      shipping: shipping ?? this.shipping,
      shippingCost: shippingCost ?? this.shippingCost,
      tradeType: tradeType ?? this.tradeType,
      price: price ?? this.price,
      tradeFor: tradeFor ?? this.tradeFor,
      tradeForDescription: tradeForDescription ?? this.tradeForDescription,
      imageUrl: imageUrl ?? this.imageUrl,
      postedDate: postedDate ?? this.postedDate,
      owner: owner ?? this.owner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address?.toMap(),
      'shipping': shipping,
      'shippingCost': shippingCost,
      'tradeType': tradeType,
      'price': price,
      'tradeFor': tradeFor,
      'tradeForDescription': tradeForDescription,
      'imageUrl': imageUrl,
      'postedDate': postedDate?.millisecondsSinceEpoch,
      'owner': owner?.toMap(),
    };
  }

  static TradeItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TradeItem(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      address: Address.fromMap(map['address']),
      shipping: map['shipping'],
      shippingCost: map['shippingCost'],
      tradeType: map['tradeType'],
      price: map['price'],
      tradeFor: map['tradeFor'],
      tradeForDescription: map['tradeForDescription'],
      imageUrl: map['imageUrl'],
      postedDate: DateTime.fromMillisecondsSinceEpoch(map['postedDate']),
      owner: User.fromMap(map['owner']),
    );
  }

  String toJson() => json.encode(toMap());

  static TradeItem fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'TradeItem(id: $id, name: $name, description: $description, address: $address, shipping: $shipping, shippingCost: $shippingCost, tradeType: $tradeType, price: $price, tradeFor: $tradeFor, tradeForDescription: $tradeForDescription, imageUrl: $imageUrl, postedDate: $postedDate, owner: $owner)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TradeItem &&
        o.id == id &&
        o.name == name &&
        o.description == description &&
        o.address == address &&
        o.shipping == shipping &&
        o.shippingCost == shippingCost &&
        o.tradeType == tradeType &&
        o.price == price &&
        o.tradeFor == tradeFor &&
        o.tradeForDescription == tradeForDescription &&
        o.imageUrl == imageUrl &&
        o.postedDate == postedDate &&
        o.owner == owner;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        address.hashCode ^
        shipping.hashCode ^
        shippingCost.hashCode ^
        tradeType.hashCode ^
        price.hashCode ^
        tradeFor.hashCode ^
        tradeForDescription.hashCode ^
        imageUrl.hashCode ^
        postedDate.hashCode ^
        owner.hashCode;
  }
}
