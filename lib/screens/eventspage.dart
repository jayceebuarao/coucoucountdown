import 'package:coucoucountdown/providers/events_provider.dart';
import 'package:coucoucountdown/screens/createeventpage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsPage extends ConsumerStatefulWidget {
  const EventsPage({super.key});

  @override
  ConsumerState<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends ConsumerState<EventsPage> {
  late Future<void> _eventsFuture;
  @override
  void initState() {
    super.initState();
    _eventsFuture = ref.read(userEventsProvider.notifier).loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    // final userEvents = ref.watch(userEventsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        centerTitle: true,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.dashboard)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CreateEventPage(),
                ));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: const Text('events will appear here'),
    );
  }
}
