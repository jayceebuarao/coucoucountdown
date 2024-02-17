import 'package:coucoucountdown/models/event.dart';
import 'package:coucoucountdown/widgets/counter.dart';
import 'package:flutter/material.dart';

class EventListTile extends StatelessWidget {
  const EventListTile(
      {super.key, required this.event, required this.onTapEvent});

  final Event event;
  final Function(BuildContext context, Event event) onTapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapEvent(context, event);
      },
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
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
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title),
                  CounterWidget(
                    eventTitle: event.title,
                    eventDate: event.eventDate,
                    timeUnit: event.timeUnit,
                  ),
                  // Text(
                  //   event.timeUnit,
                  //   style: const TextStyle(
                  //       fontSize: 36, overflow: TextOverflow.clip),
                  // ),
                  Text(event.eventDate),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox.square(
              dimension: 80,
              child: Text(
                event.icon,
                style: const TextStyle(fontSize: 48),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
