// lib/models/carrera.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Carrera {
  final int id;
  final String nombre;
  final String pais;
  final DateTime dia;
  final int piloto1;
  final int piloto2;
  final int piloto3;
  final int piloto4;
  final int piloto5;
  final int piloto6;
  final int piloto7;
  final int piloto8;
  final int piloto9;
  final int piloto10;

  Carrera({
    required this.id,
    required this.nombre,
    required this.pais,
    required this.dia,
    required this.piloto1,
    required this.piloto2,
    required this.piloto3,
    required this.piloto4,
    required this.piloto5,
    required this.piloto6,
    required this.piloto7,
    required this.piloto8,
    required this.piloto9,
    required this.piloto10,
  });

  // Convertir a Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'nombre': nombre,
      'pais': pais,
      'dia': Timestamp.fromDate(dia),
      'piloto1': piloto1,
      'piloto2': piloto2,
      'piloto3': piloto3,
      'piloto4': piloto4,
      'piloto5': piloto5,
      'piloto6': piloto6,
      'piloto7': piloto7,
      'piloto8': piloto8,
      'piloto9': piloto9,
      'piloto10': piloto10,
    };
  }

  // Constructor para crear desde Firestore
  factory Carrera.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Carrera(
      id: data['id']?.toInt() ?? 0,
      nombre: data['nombre'] ?? '',
      pais: data['pais'] ?? '',
      dia: (data['dia'] as Timestamp).toDate(),
      piloto1: data['piloto1']?.toInt() ?? 0,
      piloto2: data['piloto2']?.toInt() ?? 0,
      piloto3: data['piloto3']?.toInt() ?? 0,
      piloto4: data['piloto4']?.toInt() ?? 0,
      piloto5: data['piloto5']?.toInt() ?? 0,
      piloto6: data['piloto6']?.toInt() ?? 0,
      piloto7: data['piloto7']?.toInt() ?? 0,
      piloto8: data['piloto8']?.toInt() ?? 0,
      piloto9: data['piloto9']?.toInt() ?? 0,
      piloto10: data['piloto10']?.toInt() ?? 0,
    );
  }
}
