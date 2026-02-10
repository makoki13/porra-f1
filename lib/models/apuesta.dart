// lib/models/apuesta.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class PilotoPuntaje {
  final int piloto;
  final int puntos;

  PilotoPuntaje({
    required this.piloto,
    required this.puntos,
  });

  // Convertir a Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'piloto': piloto,
      'puntos': puntos,
    };
  }

  // Constructor para crear desde Firestore
  factory PilotoPuntaje.fromFirestore(Map<String, dynamic> data) {
    return PilotoPuntaje(
      piloto: data['piloto']?.toInt() ?? 0,
      puntos: data['puntos']?.toInt() ?? 0,
    );
  }
}

class Apuesta {
  final int carrera;
  final int jugadorId;
  final List<PilotoPuntaje> pilotosPuntajes; // Lista de pilotos con sus puntos en la carrera
  final int total;

  Apuesta({
    required this.carrera,
    required this.jugadorId,
    required this.pilotosPuntajes,
    required this.total,
  });

  // Convertir a Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'carrera': carrera,
      'jugadorId': jugadorId,
      'pilotosPuntajes': pilotosPuntajes.map((e) => e.toFirestore()).toList(),
      'total': total,
    };
  }

  // Constructor para crear desde Firestore
  factory Apuesta.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final pilotosPuntajesList = (data['pilotosPuntajes'] as List<dynamic>?)
            ?.map((e) => PilotoPuntaje.fromFirestore(e as Map<String, dynamic>))
            .toList() ??
        [];

    return Apuesta(
      carrera: data['carrera']?.toInt() ?? 0,
      jugadorId: data['jugadorId']?.toInt() ?? 0,
      pilotosPuntajes: pilotosPuntajesList,
      total: data['total']?.toInt() ?? 0,
    );
  }
}