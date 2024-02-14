import 'package:coucoucountdown/models/event.dart';
import 'package:coucoucountdown/providers/events_provider.dart';
import 'package:coucoucountdown/screens/createeventpage.dart';
import 'package:coucoucountdown/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventDetailPage extends ConsumerWidget {
  const EventDetailPage({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
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
            const SizedBox(height: 1),
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
                    onPressed: () {
                      ref
                          .read(userEventsProvider.notifier)
                          .deleteEvent(event.id);

                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${event.title} deleted')));
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('delete')),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.archive_outlined),
                    label: const Text('archive')),
                TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateEventPage(
                          isEditScreen: true,
                          event: event,
                        ),
                      ));
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('edit'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
