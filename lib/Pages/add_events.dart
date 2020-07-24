import 'package:countdown_app/app/router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:countdown_app/services/events.dart';
import 'package:countdown_app/Pages/list_of_events.dart';

TextStyle textStyle = TextStyle(
  fontSize: 18.0,
  letterSpacing: 1.0,
  color: Colors.indigo[700],
);
TextStyle textboxStyle = TextStyle(
  fontSize: 15.0,
  letterSpacing: 1.0,
  color: Colors.indigo,
);

class AddEvent extends StatefulWidget {
  final String eventName;
  final String eventDesc;
  final DateTime eventDate;
  final int index;

  const AddEvent(
      {Key key, this.eventName, this.eventDesc, this.eventDate, this.index})
      : super(key: key);
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  String _eventName;
  String _eventDesc;
  DateTime _eventDate;
  Duration _difference;
  @override
  Widget build(BuildContext context) {
    print(widget.index);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: Text('Add Event'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 50.0, 12.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.add_alert,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      'Event Name:',
                      style: textStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                  child: TextFormField(
                    maxLength: 30,
                    //controller: TextEditingController(text: _eventName),
                    style: textboxStyle,
                    initialValue: widget.eventName,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Event name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Event Name must not be empty.' : null,
                    onChanged: (val) {
                      setState(() {
                        return _eventName = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.note_add,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      'Event Description:',
                      style: textStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: TextFormField(
                    maxLength: 200,
                    //textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    //controller: TextEditingController(text: _eventDesc),
                    initialValue: widget.eventDesc,
                    style: textboxStyle,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      labelText: 'Describe your Event',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Event Name must not be empty.' : null,
                    onChanged: (val) {
                      setState(() => _eventDesc = val);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      'Event Date:',
                      style: textStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: DateTimeField(
                    // controller:
                    //     TextEditingController(text: _eventDate.toString()),
                    style: textboxStyle,
                    initialValue: widget.eventDate,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        border: OutlineInputBorder(),
                        labelText: 'Date',
                        // ignore: deprecated_member_use
                        hasFloatingPlaceholder: true),
                    format: DateFormat('EEEE MMMM d, yyyy.'),
                    onShowPicker: (context, currentValue) async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: currentValue ?? DateTime.now(),
                          firstDate: DateTime(2017),
                          lastDate: DateTime(2021));
                      print(date);
                      return _eventDate = date;
                    },
                    validator: (val) => val.isBefore(DateTime.now())
                        ? 'Invalid Event Date'
                        : null,
                    onChanged: (val) {
                      setState(() => _eventDate = val);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: RaisedButton(
        onPressed: () async {
          print('index is ' + {widget.index}.toString());
          if (_formKey.currentState.validate()) {
            if (widget.index == null) {
              _difference =
                  await Events.getDifference(_eventDate ?? widget.eventDate);
              print(_eventName);
              print(_eventDesc);
              await Events.addEvent(
                  n: _eventName ?? '',
                  de: _eventDesc ?? '',
                  da: _eventDate ?? DateTime.now(),
                  du: _difference);
              Navigator.pushReplacementNamed(context, Routes.viewEvents,
                  arguments: {
                    'eventName': _eventName,
                    'eventDescription': _eventDesc,
                    'eventDate': _eventDate,
                    'index': name.length - 1
                  });
            } else {
              _difference =
                  await Events.getDifference(_eventDate ?? widget.eventDate);
              await Events.updateEvent(
                n: _eventName ?? widget.eventName,
                de: _eventDesc ?? widget.eventDesc,
                da: _eventDate ?? widget.eventDate,
                du: _difference,
                index: widget.index
              );
              Map<String,dynamic> update = {
                'eventName': _eventName ?? widget.eventName,
                'eventDescription': _eventDesc ?? widget.eventDesc,
                'eventDate': _eventDate ?? widget.eventDate,
                'index': widget.index
              };
              Navigator.pop(context, update);
            }
          }
        },
        child: Text(
          'Save',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.indigo[700],
      ),
    );
  }
}
