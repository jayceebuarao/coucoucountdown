import 'package:coucoucountdown/models/event.dart';
import 'package:coucoucountdown/widgets/counter.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
          gradient: LinearGradient(
            colors: [
              Colors.yellow.shade700,
              Colors.yellow.shade700.withOpacity(0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 1),
            Text(
              event.title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(event.eventDate),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CounterWidget(
                eventTitle: event.title,
                eventDate: event.eventDate,
                timeUnit: event.timeUnit,
                textStyle:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Text(event.color),
            OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete_outline),
                    label: Text('delete')),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.archive_outlined),
                    label: Text('archive')),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit_outlined),
                    label: Text('edit'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
