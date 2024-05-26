//TODO: Import the missing dependencies and make the main function runnable

void main() async {
  // run crud operations on the event api
  final EventApi eventApi = EventApi();
  final event = Event(date: DateTime.now(), title: 'Test Title', description: 'Test Description');

  // post event
  final postResponse = await eventApi.postEvent(event);
  print('postResponse: $postResponse');

  // read/get event(s)
  final getResponse = await eventApi.getEventsForDate(event.date);
  print('getResponse: $getResponse');

  // update event
  final updateResponse = await eventApi.updateEventById(getResponse.last.copyWith(title: 'Updated Title', description: 'Updated Description'));
  print('updateResponse: $updateResponse');

  // delete event
  final deleteResponse = await eventApi.deleteEventById(updateResponse['data']['id']);
  print('deleteResponse: $deleteResponse');
}
