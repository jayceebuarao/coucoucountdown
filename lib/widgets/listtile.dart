import 'package:coucoucountdown/models/event.dart';
import 'package:coucoucountdown/widgets/counter.dart';
import 'package:flutter/material.dart';

class EventListTile extends StatelessWidget {
  const EventListTile({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(width: 16),
          SizedBox.square(
            dimension: 80,
            child: Text(event.icon),
          )
        ],
      ),
    );
  }
}
