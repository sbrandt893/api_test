//TODO: Make the tests pass
//TODO: Bonus-Task: Implement further tests and make them pass too

import 'dart:developer';
import 'package:api_test/backend/apis/event_api.dart';
import 'package:api_test/config.dart';
import 'package:api_test/helpers.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  //* Connection test --------------------------------------------------------------------------------------------------
  test('db connection successfully with statuscode 200', () async {
    //^ Setup
    var dio = Dio();
    var url = dbAddress;

    //! Action
    final response = await dio.get(url);

    //? Testing
    expect(response.statusCode, 200);

    // Cleanup (not necessary)
  });

  //* C-R-U-D tests ----------------------------------------------------------------------------------------------------

  final EventApi eventApi = EventApi();

  //* C(reate)-U-D-E tests ---------------------------------------------------------------------------------------------
  group('postEvent()', () {
    test('should return a map with a success message', () async {
      //^ Setup
      final event = Event(date: DateTime.now(), title: 'Test Title', description: 'Test Description');

      //! Action
      final postResponse = await eventApi.postEvent(event);
      log('postResponse: $postResponse');

      //? Testing
      expect(postResponse['success'], true);
      expect(postResponse['message'], 'Event added successfully');
      expect(postResponse['data'], isNotNull);
      expect(postResponse['data']['id'], isNotNull);
      expect(postResponse['data']['date'], getDateTimeInDbFormat(event.date));
      expect(postResponse['data']['title'], event.title);
      expect(postResponse['data']['description'], event.description);

      // Cleanup
      final deleteResponse = await eventApi.deleteEventById(postResponse['data']['id']);
      log('deleteResponse: $deleteResponse');
    });
  });

//* C-R(ead)-U-D tests -------------------------------------------------------------------------------------------------

  group('getAllEvents', () {
    test('should return a list of all events in the database', () async {
      //^ Setup
      final event = Event(date: DateTime.now(), title: 'Test Title', description: 'Test Description');
      final postResponse = await eventApi.postEvent(event);
      if (postResponse['success'] == false) {
        log('Event could not be added: $postResponse');
        return;
      }
      final postedEventId = postResponse['data']['id'];

      //! Action
      final events = await eventApi.getAllEvents();
      log('Events: $events');

      //? Testing
      expect(events, isNotEmpty);
      expect(events.any((e) => e.id == postedEventId), true);

      // Cleanup
      final deleteResponse = await eventApi.deleteEventById(postedEventId);
      log('Event deleted: $deleteResponse');
    });
  });

  group('getEventsForDate()', () {
    test('should return a list of events', () async {
      //^ Setup
      final refDate = DateTime(2000, 1, 1);
      final event = Event(date: refDate, title: 'Test Title', description: 'Test Description');
      final postResponse = await eventApi.postEvent(event);
      if (postResponse['success'] == false) {
        log('Event could not be added: $postResponse');
        return;
      }
      final postedEventId = postResponse['data']['id'];

      //! Action
      final events = await eventApi.getEventsForDate(refDate);
      log('Events: $events');

      //? Testing
      expect(events, isNotEmpty);
      expect(events.any((e) => e.date == refDate), true);

      // Cleanup
      final deleteResponse = await eventApi.deleteEventById(postedEventId);
      log('Event deleted: $deleteResponse');
    });
  });

  //* C-R-U(pdate)-D tests ---------------------------------------------------------------------------------------------

  group('updateEventById()', () {
    test('should return the updated event', () async {
      //^ Setup
      final event = Event(date: DateTime.now(), title: 'Test Title', description: 'Test Description');
      final postResponse = await eventApi.postEvent(event);
      if (postResponse['success'] == false) {
        log('Event could not be added: $postResponse');
        return;
      }
      final postedEvent = Event.fromJson(postResponse['data']);
      final newEvent = postedEvent.copyWith(title: 'Updated Test Title', description: 'Updated Test Description');

      //! Action
      final updateResponse = await eventApi.updateEventById(newEvent);
      log('Event updated: $updateResponse');

      //? Testing
      expect(updateResponse['success'], true);
      expect(updateResponse['message'], 'Event updated successfully');
      expect(updateResponse['data'], isNotNull);
      expect(updateResponse['data']['id'], postedEvent.id);
      expect(updateResponse['data']['date'], getDateTimeInDbFormat(postedEvent.date));
      expect(updateResponse['data']['title'], newEvent.title);
      expect(updateResponse['data']['description'], newEvent.description);

      // Cleanup
      final deleteResponse = await eventApi.deleteEventById(postedEvent.id!);
      log('Event deleted: $deleteResponse');
    });
  });

  //* C-R-U-D(elete) tests ---------------------------------------------------------------------------------------------
  group('deleteEventById()', () {
    test('with existing ID should return a success message', () async {
      //^ Setup
      final event = Event(date: DateTime.now(), title: 'Test Title', description: 'Test Description');
      final postResponse = await eventApi.postEvent(event);
      if (postResponse['success'] == false) {
        print('Event could not be added: $postResponse');
        return;
      }
      final postedEventId = postResponse['data']['id'];

      //! Action
      final deleteResponse = await eventApi.deleteEventById(postedEventId);
      log('Event deleted: $deleteResponse');

      //? Testing
      expect(deleteResponse['success'], true);
      expect(deleteResponse['message'], 'Event with ID $postedEventId was deleted successfully.');

      // Cleanup (not necessary)
    });
  });
}
