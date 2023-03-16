import 'package:flutter_test/flutter_test.dart';
import 'package:multiplicity_bloc_stream/bloc/history_bloc.dart';
import 'package:multiplicity_bloc_stream/events/history_events.dart';

void main() {
  multiplicityBlocTest();
}

void multiplicityBlocTest() {
  late MultiplicityBloc multiplicityBloc;

  setUp(() {
    multiplicityBloc = MultiplicityBloc();
  });

  group("Test $MultiplicityBloc", () {
    test('Multiplicity for number 123', () {
      multiplicityBloc.inputEventSink.add(HistoryEventAdd(123));

      expect(
          multiplicityBloc.outputHistoryStream,
          emits([
            "${123}:\n"
                "${123 % 3 == 0 ? 'Multiplicity 3' : 'Not multiplicity 3'}\n"
                "${123 % 5 == 0 ? 'Multiplicity 5' : 'Not multiplicity 5'}\n"
                "${123 % 7 == 0 ? 'Multiplicity 7' : 'Not multiplicity 7'}"
          ]));
    });
  });
}
