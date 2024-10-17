class EventoModel {
  String nombre;
  String precio;
  String hora;
  String descripcion;
  dynamic image;
  DateTime? fecha;
  String? userId;

  EventoModel({
    required this.nombre,
    required this.precio,
    required this.hora,
    required this.descripcion,
    this.image,
    this.fecha,
    this.userId,
  });

  factory EventoModel.fromMap(Map<String, dynamic> data) {
    return EventoModel(
      nombre: data['nombre'] ?? '',
      precio: data['precio'] ?? '',
      hora: data['hora'] ?? '',
      descripcion: data['descripcion'] ?? '',
      image: data['image'],
      fecha: data['fecha'] != null ? DateTime.parse(data['fecha']) : null,
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'precio': precio,
      'hora': hora,
      'descripcion': descripcion,
      'image': image,
      'fecha': fecha?.toIso8601String(),
      'userId': userId, // Convertir el userId a String
    };
  }

  void actualizarNombre(String nombre) {
    this.nombre = nombre;
  }

  void actualizarPrecio(String precio) {
    this.precio = precio;
  }

  void actualizarHora(String hora) {
    this.hora = hora;
  }

  void actualizarDescripcion(String descripcion) {
    this.descripcion = descripcion;
  }

  void actualizarImagen(dynamic imagen) {
    this.image = imagen;
  }

  void actualizarFecha(DateTime fecha) {
    this.fecha = fecha;
  }

  void actualizarUserId(String userId) { // Nuevo método para actualizar el userId
    this.userId = userId;
  }
}