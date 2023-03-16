import 'package:flutter/material.dart';

import '../bloc/history_bloc.dart';
import '../events/history_events.dart';

class MultiplicityPage extends StatefulWidget {
  const MultiplicityPage({super.key});

  @override
  State<StatefulWidget> createState() => _MultiplicityPageState();
}

class _MultiplicityPageState extends State<MultiplicityPage> {
  TextEditingController multiplicityController = TextEditingController();
  final MultiplicityBloc _bloc = MultiplicityBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multiplicity detector"),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.outputHistoryStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? [];

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 10.0),
                TextField(
                  controller: multiplicityController,
                  decoration: const InputDecoration(
                    labelText: "Enter number",
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    _bloc.inputEventSink.add(
                      HistoryEventAdd(
                        int.parse(multiplicityController.text),
                      ),
                    );
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: UniqueKey(),
                        child: Card(
                          child: ListTile(
                            title: Text(data[index]),
                          ),
                        ),
                        onDismissed: (direction) {
                          _bloc.inputEventSink.add(
                            HistoryEventRemove(index),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
