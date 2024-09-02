class Datum {
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
  Pivot pivot;

  Datum({
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
    required this.pivot,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
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
      pivot: Pivot.fromJson(json['pivot']),
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
      'pivot': pivot.toJson(),
    };
  }
}

class Pivot {
  int clientesId;
  int familiaresId;

  Pivot({
    required this.clientesId,
    required this.familiaresId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      clientesId: json['clientes_id'] ?? 0,
      familiaresId: json['familiares_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientes_id': clientesId,
      'familiares_id': familiaresId,
    };
  }
}
