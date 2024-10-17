
class UsuarioModel {
  String id;
  String email;
  String password;
  String name;
  String phone;
  dynamic image;
  bool isAdmin;
  bool isUser;

  UsuarioModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    this.image,
    required this.isAdmin,
    required this.isUser,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> data) {
    return UsuarioModel(
      id: data['id'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      name: data['name'] ?? '',
      image: data['image'],
      isAdmin: data['isAdmin'] ?? false,
      isUser: data['isUser'] ?? false,
      phone: data['phone'] ?? '',
    );
  }

  void actualizarEmail(String email) {
    this.email = email;
  }

  void actualizarPassword(String password) {
    this.password = password;
  }

  void actualizarNombre(String name) {
    this.name = name;
  }

  void actualizarTelefono(String phone) {
    this.phone = phone;
  }
}

