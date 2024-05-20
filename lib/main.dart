import 'package:api_test/backend/apis/event_api.dart';
import 'backend/models/event.dart';

void main() async {
  // Create a new event
  final event = Event(0, DateTime.now(), 'Test Title', 'Test Description');
  print('Event: $event');

  // Create an instance of the EventApi class
  final EventApi eventApi = EventApi();

  // add the event to the database
  final eventFromDb = await eventApi.postEvent(event);
  print('Event from DB: $eventFromDb');

  // get all events for today
  final events = await eventApi.getEventsForDate(DateTime.now());
  print('Events: $events');

  // delete the event from the database by id
  final response = await eventApi.deleteEventById(37);
  print('Event deleted: $response');
}
