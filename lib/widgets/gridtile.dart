import 'package:coucoucountdown/models/event.dart';
import 'package:coucoucountdown/widgets/counter.dart';
import 'package:flutter/material.dart';

class EventGridTile extends StatelessWidget {
  const EventGridTile(
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
                child: Text(event.icon),
              ),
              CounterWidget(
                eventTitle: event.title,
                eventDate: event.eventDate,
                timeUnit: event.timeUnit,
              ),
              Text(event.eventDate),
            ],
          )),
    );
  }
}
