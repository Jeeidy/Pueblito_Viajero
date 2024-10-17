class OfertaLaboralModel {
  final String userId;
  final String imageUrl;

  OfertaLaboralModel({
    required this.userId,
    required this.imageUrl,
  });

  factory OfertaLaboralModel.fromMap(Map<String, dynamic> data) {
    return OfertaLaboralModel(
      userId: data['userId'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
    };
  }
}