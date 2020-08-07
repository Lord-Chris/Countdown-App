import 'package:countdown_app/app/router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:countdown_app/services/events.dart';

class AddEvent extends StatefulWidget {
  final int index;

  const AddEvent({Key key, this.index}) : super(key: key);
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextStyle _textStyle = TextStyle(
    fontSize: 18.0,
    letterSpacing: 1.0,
    color: Colors.indigo[700],
  );
  TextStyle _textboxStyle = TextStyle(
    fontSize: 15.0,
    letterSpacing: 1.0,
    color: Colors.indigo,
  );

  final _formKey = GlobalKey<FormState>();
  Event _event;
  String _eventName;
  String _eventDesc;
  DateTime _eventDate;

  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.index != null) {
          Navigator.pushReplacementNamed(context, Routes.viewEvents,
              arguments: widget.index);
          return true;
        } else {
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
          return true;
        }
      },
      child: Scaffold(
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
                        style: _textStyle,
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
                      style: _textboxStyle,
                      initialValue: widget.index != null
                          ? Events.events[widget.index].name
                          : '',
                      textCapitalization: TextCapitalization.words,
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
                        style: _textStyle,
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
                      initialValue: widget.index != null
                          ? Events.events[widget.index].description
                          : '', //widget.eventDesc,
                      style: _textboxStyle,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        labelText: 'Describe your Event',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(),
                      ),
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
                        style: _textStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: DateTimeField(
                      style: _textboxStyle,
                      initialValue: widget.index != null
                          ? Events.events[widget.index].date
                          : DateTime.now(),
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                          border: OutlineInputBorder(),
                          labelText: 'Date',
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                      format: DateFormat('EEEE MMMM d, yyyy.'),
                      onShowPicker: (context, currentValue) async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: currentValue ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2021));
                        print(date);
                        return _eventDate = date;
                      },
                      validator: (val) =>
                          (val.isBefore(DateTime.now())) || (val == null)
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
            if (_formKey.currentState.validate()) {
              if (widget.index == null) {
                _event = Event(
                  name: _eventName,
                  description: _eventDesc ?? '',
                  date: _eventDate,
                );
                Events().addEvent(_event);
                Navigator.pushReplacementNamed(context, Routes.viewEvents,
                    arguments: Events.events.length - 1);
              } else {
                setState(() {});
                _event = Event(
                  name: _eventName ?? Events.events[widget.index].name,
                  description:
                      _eventDesc ?? Events.events[widget.index].description,
                  date: _eventDate ?? Events.events[widget.index].date,
                );
                Events().updateEvent(_event, widget.index);
                Navigator.pushReplacementNamed(context, Routes.viewEvents,
                    arguments: widget.index);
              }
            }
          },
          child: Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.indigo[700],
        ),
      ),
    );
  }
}
