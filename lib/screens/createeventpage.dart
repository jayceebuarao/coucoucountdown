import 'package:coucoucountdown/models/counter_unit.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  var _selectedIcon = const Icon(Icons.star);
  var _selectedColor = Colors.black;
  var isAllDay = true;

  void _saveEvent() {
    _formKey.currentState!.save();
    print(_enteredTitle);
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
      body: Padding(
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
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Event Date',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    print(value);
                  },
                ),
              ),
              //
              // EVENT TIME
              //
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: DateTimeFormField(
                          enabled: isAllDay ? false : true,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.more_time),
                            labelText: 'Event Time',
                          ),
                          mode: DateTimeFieldPickerMode.time,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (e) => (e?.day ?? 0) == 1
                              ? 'Please not the first day'
                              : null,
                          onDateSelected: (DateTime value) {
                            print(value);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text('All Day'),
                      Checkbox(
                        value: isAllDay,
                        onChanged: (value) {
                          setState(() {
                            isAllDay = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              //
              // COUNTER UNIT
              //
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      labelText: 'Counter Unit',
                    ),
                    items: CounterUnits.values.map((counterUnit) {
                      return DropdownMenuItem(
                          value: counterUnit, child: Text(counterUnit.name));
                    }).toList(),
                    onChanged: (onChanged) {}),
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
                            onTap: () {
                              print('color selected');
                            },
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
                            onTap: () {
                              print('color selected');
                            },
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
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Start Date',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    print(value);
                  },
                ),
              ),
              //
              // START TIME
              //
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: DateTimeFormField(
                          enabled: isAllDay ? false : true,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.more_time),
                            labelText: 'Start Time',
                          ),
                          mode: DateTimeFieldPickerMode.time,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (e) => (e?.day ?? 0) == 1
                              ? 'Please not the first day'
                              : null,
                          onDateSelected: (DateTime value) {
                            print(value);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text('All Day'),
                      Checkbox(
                        value: isAllDay,
                        onChanged: (value) {
                          setState(() {
                            isAllDay = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
