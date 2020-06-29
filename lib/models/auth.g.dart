// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthAdapter extends TypeAdapter<Auth> {
  @override
  final typeId = 0;

  @override
  Auth read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Auth(
      jwt: fields[0] as String,
      role: fields[1] as int,
      status: fields[2] as int,
      user: fields[3] as User,
    );
  }

  @override
  void write(BinaryWriter writer, Auth obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.jwt)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.user);
  }
}
