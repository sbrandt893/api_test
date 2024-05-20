import 'dart:convert';
import 'dart:developer';
import 'package:api_test/backend/models/event.dart';
import 'package:dio/dio.dart';

class EventApi {
  final String apiUrl = 'http://localhost/calendar_project/events.php';

  Future<Event?> postEvent(Event event) async {
    final dio = Dio();
    try {
      // Führen Sie eine POST-Anfrage an die API aus
      final response = await dio.post(
        apiUrl,
        data: event.toJson(),
        queryParameters: {'action': 'addEvent'},
      );
      // Interpretiere die API-Antwort direkt als JSON und parse sie in ein Ereignisobjekt
      final jsonData = json.decode(response.data);
      return Event.fromJson(jsonData);
    } catch (e) {
      print('Fehler beim Senden der Anfrage: $e');
    }
    return null;
  }

  Future<List<Event>> getEventsForDate(DateTime date) async {
    final dateString = date.toIso8601String().substring(0, 10);
    final dio = Dio();
    List<Event> events = [];
    try {
      // Führen Sie eine GET-Anfrage an die API aus
      final response = await dio.get(
        apiUrl,
        queryParameters: {'action': 'getEventsForDate', 'date': dateString},
      );

      // Interpretiere die API-Antwort direkt als JSON und parse sie in eine Liste von Ereignisobjekten
      final jsonData = json.decode(response.data);
      log('jsonData: $jsonData');
      events = jsonData.map<Event>((e) => Event.fromJson(e)).toList();
    } catch (e) {
      print('Fehler beim Senden der Anfrage: $e');
    }
    return events;
  }

  Future<Map<String, dynamic>> deleteEventById(int id) async {
    final dio = Dio();
    try {
      // Führen Sie eine DELETE-Anfrage an die API aus
      final response = await dio.delete(
        apiUrl,
        queryParameters: {'action': 'deleteEventById', 'id': id},
      );
      // Interpretiere die API-Antwort direkt als JSON
      final jsonData = json.decode(response.data);
      return jsonData;
    } catch (e) {
      print('Fehler beim Senden der Anfrage: $e');
      // Gib ein Fehler-Objekt zurück
      return {
        'success': false,
        'message': 'Fehler beim Senden der Anfrage: $e'
      };
    }
  }

  // Future<bool> deleteEventById(int id) async {
  //   final dio = Dio();
  //   try {
  //     // Führen Sie eine POST-Anfrage an die API aus
  //     final response = await dio.delete(
  //       apiUrl,
  //       queryParameters: {'action': 'deleteEventById', 'id': id},
  //     );
  //     // Interpretiere die API-Antwort direkt als JSON
  //     final jsonData = json.decode(response.data);
  //     return jsonData['success'];
  //   } catch (e) {
  //     print('Fehler beim Senden der Anfrage: $e');
  //   }
  //   return false;
  // }
}
