import 'package:coucoucountdown/models/event.dart';
import 'package:coucoucountdown/widgets/counter.dart';
import 'package:flutter/material.dart';

class EventGridTile extends StatelessWidget {
  const EventGridTile({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: const [
              BoxShadow(offset: Offset(0, 5), color: Colors.black)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(event.title),
            SizedBox.square(
              dimension: 80,
              child: Text(event.icon),
            ),
            CounterWidget(
              eventDate: event.eventDate,
              timeUnit: event.timeUnit,
            ),
            Text(event.eventDate),
          ],
        ));
  }
}
