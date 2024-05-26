import 'package:api_test/helpers.dart';

///Represents a historical event with a [date], [title], and optional [description].
class Event {
  final int? id;
  final DateTime date;
  final String title;
  final String? description;

  Event({
    this.id,
    required this.date,
    required this.title,
    this.description,
  });

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = DateTime.parse(json['date']),
        title = json['title'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': getDateTimeInDbFormat(date),
        'title': title,
        'description': description,
      };

  @override
  String toString() {
    return 'Event{id: $id, date: $date, title: $title, description: $description}';
  }

  Event copyWith({
    int? id,
    DateTime? date,
    String? title,
    String? description,
  }) {
    return Event(
      id: id ?? this.id,
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
