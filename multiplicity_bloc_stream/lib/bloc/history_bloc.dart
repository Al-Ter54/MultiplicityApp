import 'dart:async';

import '../events/history_events.dart';

class MultiplicityBloc {
  MultiplicityBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  final List<String> _history = [];

  final _inputEventController = StreamController<HistoryEvent>();

  StreamSink<HistoryEvent> get inputEventSink => _inputEventController.sink;

  final _outputStreamController = StreamController<List<String>>();

  Stream<List<String>> get outputHistoryStream =>
      _outputStreamController.stream;

  void _mapEventToState(HistoryEvent event) {
    if (event.type == HistoryEventType.historyAdd) {
      _history.add("${event.data}:\n"
          "${event.data % 3 == 0 ? 'Multiplicity 3' : 'Not multiplicity 3'}\n"
          "${event.data % 5 == 0 ? 'Multiplicity 5' : 'Not multiplicity 5'}\n"
          "${event.data % 7 == 0 ? 'Multiplicity 7' : 'Not multiplicity 7'}");
    } else if (event.type == HistoryEventType.historyRemove) {
      _history.removeAt(event.data);
    } else {
      throw Exception("Wrong event type");
    }
    _outputStreamController.sink.add(_history);
  }

  void dispose() {
    _outputStreamController.close();
    _inputEventController.close();
  }
}
