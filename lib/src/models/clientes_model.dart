import 'dart:convert';

class Cliente {
  int id;
  String nombre;
  String apellido1;
  String apellido2;
  String email;
  String password;
  String estado;
  String? ubicacion;
  String? usuario;
  String? ultimaUbicacion;

  Cliente({
    required this.id,
    required this.nombre,
    required this.apellido1,
    required this.apellido2,
    required this.email,
    required this.password,
    required this.estado,
    this.ubicacion,
    this.usuario,
    this.ultimaUbicacion,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellido1: json['apellido1'] ?? '',
      apellido2: json['apellido2'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      estado: json['estado'] ?? '',
      ubicacion: json['ubicacion'],
      usuario: json['usuario'],
      ultimaUbicacion: json['ultima_ubicacion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido1': apellido1,
      'apellido2': apellido2,
      'email': email,
      'password': password,
      'estado': estado,
      'ubicacion': ubicacion,
      'usuario': usuario,
      'ultima_ubicacion': ultimaUbicacion,
    };
  }
}

class Welcome {
  List<Datum>? data;

  Welcome({
    this.data,
  });

  factory Welcome.fromRawJson(String str) => Welcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? nombre;
  String? apellido1;
  String? apellido2;
  String? email;
  String? password;
  String? estado;
  dynamic ubicacion;
  dynamic usuario;
  dynamic ultimaUbicacion;
  Pivot? pivot;

  Datum({
    this.id,
    this.nombre,
    this.apellido1,
    this.apellido2,
    this.email,
    this.password,
    this.estado,
    this.ubicacion,
    this.usuario,
    this.ultimaUbicacion,
    this.pivot,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nombre: json["nombre"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        email: json["email"],
        password: json["password"],
        estado: json["estado"],
        ubicacion: json["ubicacion"],
        usuario: json["usuario"],
        ultimaUbicacion: json["ultima_ubicacion"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido1": apellido1,
        "apellido2": apellido2,
        "email": email,
        "password": password,
        "estado": estado,
        "ubicacion": ubicacion,
        "usuario": usuario,
        "ultima_ubicacion": ultimaUbicacion,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  int? clientesId;
  int? familiaresId;

  Pivot({
    this.clientesId,
    this.familiaresId,
  });

  factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        clientesId: json["clientes_id"],
        familiaresId: json["familiares_id"],
      );

  Map<String, dynamic> toJson() => {
        "clientes_id": clientesId,
        "familiares_id": familiaresId,
      };
}
