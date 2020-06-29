import 'dart:convert';

class Address {
  int id;
  String address1;
  String address2;
  String city; // City/Town
  String postcode; // Zip/Postal Code
  String state; // State/Province/Region
  String country;
  double latitude;
  double longitude;

  Address({
    this.id,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address1': address1,
      'address2': address2,
      'city': city,
      'postcode': postcode,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  String get area => this.city + ', ' + this.state;

  Address copyWith({
    int id,
    String address1,
    String address2,
    String city,
    String postcode,
    String state,
    String country,
    double latitude,
    double longitude,
  }) {
    return Address(
      id: id ?? this.id,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      postcode: postcode ?? this.postcode,
      state: state ?? this.state,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  static Address fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Address(
      id: map['id'],
      address1: map['address1'],
      address2: map['address2'],
      city: map['city'],
      postcode: map['postcode'],
      state: map['state'],
      country: map['country'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  static Address fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(id: $id, address1: $address1, address2: $address2, city: $city, postcode: $postcode, state: $state, country: $country, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Address &&
        o.id == id &&
        o.address1 == address1 &&
        o.address2 == address2 &&
        o.city == city &&
        o.postcode == postcode &&
        o.state == state &&
        o.country == country &&
        o.latitude == latitude &&
        o.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        address1.hashCode ^
        address2.hashCode ^
        city.hashCode ^
        postcode.hashCode ^
        state.hashCode ^
        country.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
