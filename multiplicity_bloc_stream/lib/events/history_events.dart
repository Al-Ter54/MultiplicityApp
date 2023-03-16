enum HistoryEventType { historyAdd, historyRemove }

abstract class HistoryEvent {
  abstract HistoryEventType type;
  int data;

  HistoryEvent(this.data);
}

class HistoryEventAdd extends HistoryEvent {
  @override
  HistoryEventType type = HistoryEventType.historyAdd;

  HistoryEventAdd(super.data);
}

class HistoryEventRemove extends HistoryEvent {
  @override
  HistoryEventType type = HistoryEventType.historyRemove;

  HistoryEventRemove(super.data);
}
