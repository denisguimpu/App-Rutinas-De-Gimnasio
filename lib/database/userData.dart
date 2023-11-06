class UserData {
  final double weight;
  final double height;
  final double waist;
  final double neck;
  final double hip;

  UserData({
    required this.weight,
    required this.height,
    required this.waist,
    required this.neck,
    required this.hip,
  });

  // Convierte un mapa a UserData
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      weight: map['weight'],
      height: map['height'],
      waist: map['waist'],
      neck: map['neck'],
      hip: map['hip'],
    );
  }

  // Convierte UserData a un mapa
  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'height': height,
      'waist': waist,
      'neck': neck,
      'hip': hip,
    };
  }
}
