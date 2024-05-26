import 'dart:convert';
import 'dart:developer';
import 'package:api_test/backend/models/event.dart';
import 'package:api_test/config.dart';
import 'package:api_test/helpers.dart';
import 'package:dio/dio.dart';

///API class for handling events in the database.
///
///The class provides methods for creating, reading, updating, and deleting events in the database.
class EventApi {
  final String apiUrl = dbAddress;

//* C(reate)-U-D-E methods ------------------------------------------------------------------------------------------

  // postEvent()

  /// Sends a POST request to the database to add an [Event].
  ///
  /// Returns:
  /// - a map with a [success], [message] and [data] key
  ///   - [success] is true if the event was added successfully, false otherwise
  ///   - [message] contains a success or error message
  ///   - [data] contains the added event if successful, or the error if unsuccessful
  Future<Map<String, dynamic>> postEvent(Event event) async {
    final dio = Dio();
    try {
      final response = await dio.post(
        apiUrl,
        data: event.toJson(),
        queryParameters: {'action': 'addEvent'},
      );
      final jsonData = json.decode(response.data);
      if (!jsonData.containsKey('id')) {
        return {'success': false, 'message': 'Event failed to add', 'data': jsonData};
      }
      return {'success': true, 'message': 'Event added successfully', 'data': jsonData};
    } catch (e) {
      log('Fehler beim Senden der Anfrage: $e');
      return {'success': false, 'message': 'Error while sending request', 'data': e};
    }
  }

  //* C-R(ead)-U-D methods ------------------------------------------------------------------------------------------

  Future<List<Event>> getEventsForDate(DateTime date) async {
    final dateString = getDateTimeInDbFormat(date);
    final dio = Dio();
    List<Event> events = [];
    try {
      final response = await dio.get(
        apiUrl,
        queryParameters: {'action': 'getEventsForDate', 'date': dateString},
      );
      final jsonData = json.decode(response.data);
      log('jsonData: $jsonData');
      events = jsonData.map<Event>((e) => Event.fromJson(e)).toList();
    } catch (e) {
      print('Fehler beim Senden der Anfrage: $e');
    }
    return events;
  }

  Future<Event?> getEventById(int id) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        apiUrl,
        queryParameters: {'action': 'getEventById', 'id': id},
      );
      print('response.data: ${response.data}');
      if (!response.data.contains('id')) {
        log('response.data: ${response.data}');
        return null;
      } else {
        final jsonData = json.decode(response.data);
        return Event.fromJson(jsonData);
      }
    } catch (e) {
      print('Fehler beim Senden der Anfrage: $e');
    }
    return null;
  }

  //* C-R-U(pdate)-D methods ------------------------------------------------------------------------------------------

  Future<Map<String, dynamic>> updateEventById(Event event) async {
    final dio = Dio();
    try {
      final response = await dio.put(
        apiUrl,
        data: event.toJson(),
        queryParameters: {'action': 'updateEventById', 'id': event.id},
      );
      final jsonData = json.decode(response.data);
      if (!jsonData.containsKey('id')) {
        return {'success': false, 'message': 'Event failed to update', 'data': jsonData};
      }
      return {'success': true, 'message': 'Event updated successfully', 'data': jsonData};
    } catch (e) {
      log('Fehler beim Senden der Anfrage: $e');
      return {'success': false, 'message': 'Error while sending request', 'data': e};
    }
  }

  //* C-R-U-D(elete) methods ------------------------------------------------------------------------------------------

  Future<Map<String, dynamic>> deleteEventById(int id) async {
    final dio = Dio();
    try {
      final response = await dio.delete(
        apiUrl,
        queryParameters: {'action': 'deleteEventById', 'id': id},
      );
      final jsonData = json.decode(response.data);
      return jsonData;
    } catch (e) {
      log('Fehler beim Senden der Anfrage: $e');
      return {'success': false, 'message': 'Fehler beim Senden der Anfrage: $e'};
    }
  }

  Future<List<Event>> getAllEvents() async {
    final dio = Dio();
    List<Event> events = [];
    try {
      final response = await dio.get(
        apiUrl,
        queryParameters: {'action': 'getAllEvents'},
      );
      final jsonData = json.decode(response.data);
      log('jsonData: $jsonData');
      events = jsonData.map<Event>((e) => Event.fromJson(e)).toList();
    } catch (e) {
      print('Fehler beim Senden der Anfrage: $e');
    }
    return events;
  }
}
