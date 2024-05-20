/// Class Event which represents a historical event
class Event {
  final int id;
  final DateTime date;
  final String title;
  final String description;

  Event(this.id, this.date, this.title, this.description);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      // wenn id ein String ist, dann wird es in int umgewandelt ansonsten bleibt es int
      json['id'] is String ? int.parse(json['id']) : json['id'],
      // datetime without hours and minutes and seconds
      DateTime.parse(json['date']),
      json['title'],
      json['description'],
    );
  }

  // Event-Objekt in ein JSON-Objekt umwandeln
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String().substring(0, 10),
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Event{id: $id, date: $date, title: $title, description: $description}';
  }
}
