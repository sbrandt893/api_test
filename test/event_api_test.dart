import 'package:api_test/backend/apis/event_api.dart';
import 'package:api_test/backend/models/event.dart';
import 'package:api_test/helpers.dart';
import 'package:test/test.dart';

void main() {
  final EventApi eventApi = EventApi();
  group('eventApi.postEvent()', () {
    test('should return the sent event with an id assigned by the db',
        () async {
      // Create a new event
      final event = Event(0, DateTime.now(), 'Test Title', 'Test Description');

      // add the event to the database
      final Event? eventFromDb = await eventApi.postEvent(event);
      expect(eventFromDb?.id, isNotNull);
      expect(eventFromDb?.id, isNot(0));
      expect(eventFromDb?.date, dateTimeDBformat(event.date));
      expect(eventFromDb?.title, event.title);
      expect(eventFromDb?.description, event.description);
    });
  });

  group('getEventsForDate()', () {
    test('should return a list of events', () async {
      // get all events for today
      final events = await eventApi.getEventsForDate(DateTime.now());
      print('Events: $events');
      expect(events, isNotEmpty);
    });
  });
}
