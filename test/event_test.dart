import 'package:api_test/backend/models/event.dart';
import 'package:test/test.dart';

void main() {
  test('Event() constructor should create a new Event object', () {
    final event = Event(0, DateTime.now(), 'Test Title', 'Test Description');
    expect(event.id, 0);
    expect(event.date, isNotNull);
    expect(event.title, 'Test Title');
    expect(event.description, 'Test Description');
  });

  test('Event.fromJson() should create a new Event object from a JSON object',
      () {
    final json = {
      'id': 1,
      'date': '2024-04-21',
      'title': 'Test Title',
      'description': 'Test Description',
    };
    final event = Event.fromJson(json);
    expect(event.id, 1);
    expect(event.date, DateTime(2024, 4, 21));
    expect(event.title, 'Test Title');
    expect(event.description, 'Test Description');
  });

  test('Event.toJson() should return a JSON object from an Event object', () {
    final event =
        Event(1, DateTime(2024, 4, 21), 'Test Title', 'Test Description');
    final json = event.toJson();
    expect(json['id'], 1);
    expect(json['date'], '2024-04-21');
    expect(json['title'], 'Test Title');
    expect(json['description'], 'Test Description');
  });

  test('Event.toString() should return a string representation of the Event',
      () {
    final event =
        Event(1, DateTime(2024, 4, 21), 'Test Title', 'Test Description');
    expect(event.toString(),
        'Event{id: 1, date: 2024-04-21 00:00:00.000, title: Test Title, description: Test Description}');
  });
}
