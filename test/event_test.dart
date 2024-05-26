import 'package:api_test/backend/models/event.dart';
import 'package:test/test.dart';

void main() {
  test('Event() should construct a new Event object with given parameters', () {
    final event = Event(date: DateTime.now(), title: 'Test Title', description: 'Test Description');
    expect(event.id, isNull);
    expect(event.date, isNotNull);
    expect(event.title, 'Test Title');
    expect(event.description, 'Test Description');
  });

  test('Event.fromJson() should create an Event from a JSON object', () {
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

  test('Event.toJson() should create a JSON from an Event object', () {
    final event = Event(date: DateTime(2024, 4, 21), title: 'Test Title', description: 'Test Description');
    final json = event.toJson();
    expect(json['id'], null);
    expect(json['date'], '2024-04-21');
    expect(json['title'], 'Test Title');
    expect(json['description'], 'Test Description');
  });

  test('Event.toString() should return a string representation of the Event', () {
    final event = Event(date: DateTime(2024, 4, 21), title: 'Test Title', description: 'Test Description');
    expect(event.toString(), 'Event{id: null, date: 2024-04-21 00:00:00.000, title: Test Title, description: Test Description}');
  });

  test('Event.copyWith() should return a new Event object with updated values', () {
    final event = Event(date: DateTime(2024, 4, 21), title: 'Test Title', description: 'Test Description');
    final updatedEvent = event.copyWith(title: 'Updated Title', description: 'Updated Description');
    expect(updatedEvent.id, null);
    expect(updatedEvent.date, DateTime(2024, 4, 21));
    expect(updatedEvent.title, 'Updated Title');
    expect(updatedEvent.description, 'Updated Description');
  });
}
