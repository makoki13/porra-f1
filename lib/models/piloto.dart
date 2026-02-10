// lib/models/piloto.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Piloto {
  final int id;
  final String nombre;
  final String escuderia;

  Piloto({
    required this.id,
    required this.nombre,
    required this.escuderia,
  });

  // Convertir a Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'nombre': nombre,
      'escuderia': escuderia,
    };
  }

  // Constructor para crear desde Firestore
  factory Piloto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Piloto(
      id: data['id']?.toInt() ?? 0,
      nombre: data['nombre'] ?? '',
      escuderia: data['escuderia'] ?? '',
    );
  }
}