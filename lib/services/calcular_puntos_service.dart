// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/carrera.dart';
import '../models/jugador.dart';
import '../models/apuesta.dart';

class CalcularPuntosService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sistema de puntos de F1
  static const Map<int, int> puntosPorPosicion = {
    1: 25,
    2: 18,
    3: 15,
    4: 12,
    5: 10,
    6: 8,
    7: 6,
    8: 4,
    9: 2,
    10: 1,
  };

  Future<void> calcularPuntos(int usuarioIdEjecutor) async {
    if (usuarioIdEjecutor != 0) {
      throw Exception("Solo el administrador (ID=0) puede ejecutar este servicio.");
    }

    // Obtener la última carrera celebrada
    final QuerySnapshot carrerasSnapshot = await _firestore
        .collection('carreras')
        .orderBy('dia', descending: true)
        .limit(1)
        .get();

    if (carrerasSnapshot.docs.isEmpty) {
      print("No hay carreras registradas aún.");
      return;
    }

    final carreraDoc = carrerasSnapshot.docs.first;
    final Carrera carrera = Carrera.fromFirestore(carreraDoc);

    // Obtener todos los jugadores
    final QuerySnapshot jugadoresSnapshot = await _firestore.collection('jugadores').get();
    final List<Jugador> jugadores = jugadoresSnapshot.docs
        .map((doc) => Jugador.fromFirestore(doc))
        .toList();

    // Iterar sobre cada jugador para calcular puntos
    for (final jugador in jugadores) {
      final List<int> idsPilotosSeleccionados = [
        jugador.jugador1,
        jugador.jugador2,
        jugador.jugador3,
        jugador.jugador4,
        jugador.jugador5,
      ];

      // Obtener los IDs de los pilotos que puntúan en la carrera
      final List<int> idsClasificados = [
        carrera.piloto1,
        carrera.piloto2,
        carrera.piloto3,
        carrera.piloto4,
        carrera.piloto5,
        carrera.piloto6,
        carrera.piloto7,
        carrera.piloto8,
        carrera.piloto9,
        carrera.piloto10,
      ];

      // Calcular puntos para los pilotos seleccionados
      int totalPuntos = 0;
      List<PilotoPuntaje> pilotosPuntajes = [];

      for (int i = 0; i < idsClasificados.length; i++) {
        int posicion = i + 1;
        int idPiloto = idsClasificados[i];
        int puntos = puntosPorPosicion[posicion] ?? 0;

        if (idsPilotosSeleccionados.contains(idPiloto)) {
          pilotosPuntajes.add(PilotoPuntaje(piloto: idPiloto, puntos: puntos));
          totalPuntos += puntos;
        }
      }

      // Crear o actualizar el registro de apuesta para esta carrera
      final apuesta = Apuesta(
        carrera: carrera.id,
        jugadorId: jugador.id,
        pilotosPuntajes: pilotosPuntajes,
        total: totalPuntos,
      );

      // Subir la apuesta a Firestore
      await _firestore.collection('apuestas').add(apuesta.toFirestore());

      // Sumar puntos al jugador en la colección de jugadores
      await _firestore
          .collection('jugadores')
          .doc(jugador.id.toString())
          .update({'puntos': FieldValue.increment(totalPuntos)});
    }

    print("Cálculo de puntos completado para la carrera ${carrera.nombre}.");
  }
}