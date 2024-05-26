import 'dart:convert';
import 'dart:developer';
import 'package:api_test/config.dart';
import 'package:dio/dio.dart';

//TODO: Implement the missing EventApi methods as described in the test/event_api_test.dart file

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

  //* C-R-U(pdate)-D methods ------------------------------------------------------------------------------------------

  //* C-R-U-D(elete) methods ------------------------------------------------------------------------------------------
}
