// lib/models/jugador.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Jugador {
  final int id;
  final String nombre;
  final int puntos;
  final int jugador1;
  final int jugador2;
  final int jugador3;
  final int jugador4;
  final int jugador5;

  Jugador({
    required this.id,
    required this.nombre,
    required this.puntos,
    required this.jugador1,
    required this.jugador2,
    required this.jugador3,
    required this.jugador4,
    required this.jugador5,
  });

  // Convertir a Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'nombre': nombre,
      'puntos': puntos,
      'jugador1': jugador1,
      'jugador2': jugador2,
      'jugador3': jugador3,
      'jugador4': jugador4,
      'jugador5': jugador5,
    };
  }

  // Constructor para crear desde Firestore
  factory Jugador.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Jugador(
      id: data['id']?.toInt() ?? 0,
      nombre: data['nombre'] ?? '',
      puntos: data['puntos']?.toInt() ?? 0,
      jugador1: data['jugador1']?.toInt() ?? 0,
      jugador2: data['jugador2']?.toInt() ?? 0,
      jugador3: data['jugador3']?.toInt() ?? 0,
      jugador4: data['jugador4']?.toInt() ?? 0,
      jugador5: data['jugador5']?.toInt() ?? 0,
    );
  }
}