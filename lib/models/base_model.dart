abstract class BaseModel {
  int id;
  int status;
  int updatedBy;
  int createdBy;
  DateTime updatedAt;
  DateTime createdAt;

  BaseModel({
    this.id,
    this.status,
    this.updatedBy,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
  });

  BaseModel fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap();

  // User.initial()
  //     : id = 0,
  //       fullName = '',
  //       identityPassport = '',
  //       contactNo = '',
  //       address1 = '',
  //       address2 = '',
  //       postcode = '',
  //       city = '',
  //       state = '',
  //       country = '',
  //       idUrl = '',
  //       status = 0;

  // User.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   fullName = json['fullName'];
  //   identityPassport = json['identityPassport'];
  //   contactNo = json['contactNo'];
  //   address1 = json['address1'];
  //   address2 = json['address2'];
  //   postcode = json['postcode'];
  //   city = json['city'];
  //   state = json['state'];
  //   country = json['country'];
  //   idUrl = json['idUrl'];
  //   status = json['status'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['fullName'] = this.fullName;
  //   data['identityPassport'] = this.identityPassport;
  //   data['contactNo'] = this.contactNo;
  //   data['address1'] = this.address1;
  //   if (this.address2.length > 0) {
  //     data['address2'] = this.address2;
  //   }
  //   data['postcode'] = this.postcode;
  //   data['city'] = this.city;
  //   data['state'] = this.state;
  //   data['country'] = this.country;
  //   if (this.idUrl != null) {
  //     data['idUrl'] = this.idUrl;
  //   }
  //   if (this.status != null) {
  //     data['status'] = this.status;
  //   }
  //   return data;
  // }
}

// List<T> list = new List<T>.from(items.map((item) => T.fromJson(item)))
