import 'package:coucoucountdown/models/event.dart';
import 'package:coucoucountdown/providers/events_provider.dart';
import 'package:coucoucountdown/screens/createeventpage.dart';
import 'package:coucoucountdown/screens/eventdetailpage.dart';
import 'package:coucoucountdown/widgets/gridtile.dart';
import 'package:coucoucountdown/widgets/listtile.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsPage extends ConsumerStatefulWidget {
  const EventsPage({super.key});

  @override
  ConsumerState<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends ConsumerState<EventsPage> {
  late Future<void> _eventsFuture;

  var isListView = true;
  var viewIcon = const Icon(Icons.view_list);

  @override
  void initState() {
    super.initState();
    _eventsFuture = ref.read(userEventsProvider.notifier).loadEvents();
  }

  void _onTapEvent(BuildContext context, Event event) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EventDetailPage(
        event: event,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final userEvents = ref.watch(userEventsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              setState(() {
                isListView = !isListView;
                isListView
                    ? viewIcon = const Icon(Icons.view_list_rounded)
                    : viewIcon = const Icon(Icons.view_cozy_rounded);
              });
            },
            icon: viewIcon),
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
      body: FutureBuilder(
          future: _eventsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return isListView == true
                  ? ListView.separated(
                      padding: const EdgeInsets.all(16),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemCount: userEvents.length,
                      itemBuilder: (context, index) {
                        return EventListTile(
                          event: userEvents[index],
                          onTapEvent: _onTapEvent,
                        );
                      },
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16),
                      itemCount: userEvents.length,
                      itemBuilder: (context, index) {
                        return EventGridTile(
                          event: userEvents[index],
                          onTapEvent: _onTapEvent,
                        );
                      },
                    );
            }
          }),
    );
  }
}
