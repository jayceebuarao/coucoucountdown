// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields

import 'package:coucoucountdown/models/event.dart';
import 'package:coucoucountdown/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateEventPage extends ConsumerStatefulWidget {
  const CreateEventPage({super.key});

  @override
  ConsumerState<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends ConsumerState<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle;
  var _enteredEventDate;
  var _enteredTimeUnit;
  var _selectedIcon = IconData(Icons.abc.codePoint);
  Color _selectedColor = Colors.black;

  void _saveEvent() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      ref.read(userEventsProvider.notifier).addEvent(
            Event(
              title: _enteredTitle,
              eventDate: _enteredEventDate.toString(),
              timeUnit: _enteredTimeUnit.toString(),
              color: _selectedColor.toString(),
              icon: _selectedIcon.toString(),
            ),
          );

      print('Go Back to Events Page');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
        actions: [
          IconButton(onPressed: _saveEvent, icon: const Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //
                // TITLE
                //
                TextFormField(
                  maxLength: 30,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text('Title')),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 30) {
                      return 'Must be between 1 and 30 characters';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredTitle = newValue!;
                  },
                ),
                //
                // EVENT DATE
                //
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'Event Date and Time'),
                    mode: DateTimeFieldPickerMode.dateAndTime,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (e) =>
                        (e == null) ? 'Please enter a valid date' : null,
                    onDateSelected: (DateTime value) {
                      _enteredEventDate = value;
                    },
                  ),
                ),
                //
                // COUNTER UNIT
                //
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Counter Unit',
                    ),
                    items: CounterUnits.values.map((counterUnit) {
                      return DropdownMenuItem(
                          value: counterUnit, child: Text(counterUnit.name));
                    }).toList(),
                    validator: (e) =>
                        (e == null) ? 'Please enter a valid date' : null,
                    onChanged: (value) {
                      setState(() {
                        _enteredTimeUnit = value!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      // ICON SELECTOR
                      //
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Icon'),
                            InkWell(
                              onTap: () {},
                              splashColor: Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                width: double.infinity,
                                child: const Icon(Icons.colorize_outlined),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      //
                      // COLOR SELECTOR
                      //
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Color'),
                            InkWell(
                              onTap: () {},
                              splashColor: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: _selectedColor,
                                    borderRadius: BorderRadius.circular(5)),
                                width: double.infinity,
                                child: const Text('hello'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //
                // START DATE
                //
                // Padding(
                //   padding: const EdgeInsets.only(top: 16.0),
                //   child: DateTimeFormField(
                //     decoration: const InputDecoration(
                //       hintStyle: TextStyle(color: Colors.black45),
                //       errorStyle: TextStyle(color: Colors.redAccent),
                //       border: OutlineInputBorder(),
                //       suffixIcon: Icon(Icons.event_note),
                //       labelText: 'Start Date',
                //     ),
                //     mode: DateTimeFieldPickerMode.date,
                //     autovalidateMode: AutovalidateMode.always,
                //     validator: (e) =>
                //         (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                //     onDateSelected: (DateTime value) {
                //       print(value);
                //     },
                //   ),
                // ),
                //
                // START TIME
                //
                // Padding(
                //   padding: const EdgeInsets.only(top: 16),
                //   child: Container(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Expanded(
                //           child: DateTimeFormField(
                //             enabled: isAllDay ? false : true,
                //             decoration: const InputDecoration(
                //               hintStyle: TextStyle(color: Colors.black45),
                //               errorStyle: TextStyle(color: Colors.redAccent),
                //               border: OutlineInputBorder(),
                //               suffixIcon: Icon(Icons.more_time),
                //               labelText: 'Start Time',
                //             ),
                //             mode: DateTimeFieldPickerMode.time,
                //             autovalidateMode: AutovalidateMode.always,
                //             validator: (e) => (e?.day ?? 0) == 1
                //                 ? 'Please not the first day'
                //                 : null,
                //             onDateSelected: (DateTime value) {
                //               print(value);
                //             },
                //           ),
                //         ),
                //         const SizedBox(width: 16),
                //         const Text('All Day'),
                //         Checkbox(
                //           value: isAllDay,
                //           onChanged: (value) {
                //             setState(() {
                //               isAllDay = value!;
                //             });
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
