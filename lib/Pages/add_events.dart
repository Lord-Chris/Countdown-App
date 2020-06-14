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
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {

  TextEditingController eventName = TextEditingController();
  TextEditingController eventName1;
  TextEditingController eventDescription = TextEditingController();
  TextEditingController eventDescription1;
  TextEditingController eventDate = TextEditingController();
  TextEditingController eventDate1;
  var errorMessage;
  var errorMessageDate;


  @override
  Widget build(BuildContext context) {

    Map eventData = ModalRoute.of(context).settings.arguments;
    //print('evenData is $eventData');
    bool isDataEmpty= eventData==null ? true:false;
    //print(isDataEmpty);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: Text('Add Event'),
      ),
      body: SingleChildScrollView(
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
                  SizedBox(width: 6.0,),
                  Text(
                    'Event Name:',
                    style: textStyle,
                  ),
                ],
              ),
              SizedBox(height: 12.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                child: TextField(
                  maxLength: 30,
                  controller: isDataEmpty ? eventName : eventName1  = TextEditingController(text: eventData['eventName']),
                  style: textboxStyle,
                  decoration: InputDecoration(
                    errorText: errorMessage,
                    contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    hasFloatingPlaceholder: true,
                    labelText: 'Event name',
                    border: OutlineInputBorder(
                      //borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.note_add,
                    color: Colors.indigo,
                  ),
                  SizedBox(width: 6.0,),
                  Text(
                    'Event Description:',
                    style: textStyle,
                  ),
                ],
              ),
              SizedBox(height: 12.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: TextField(
                  maxLength: 200,
                  //textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: isDataEmpty ? eventDescription : eventDescription1 = TextEditingController(text: eventData['eventDescription']),
                  style: textboxStyle,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    labelText: 'Describe your Event',
                    hasFloatingPlaceholder: true,
                    border: OutlineInputBorder(
                      //borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.date_range,
                    color: Colors.indigo,
                  ),
                  SizedBox(width: 6.0,),
                  Text(
                    'Event Date:',
                    style: textStyle,
                  ),
                ],
              ),
              SizedBox(height: 12.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: DateTimeField(
                  controller: isDataEmpty ? eventDate : eventDate1 = TextEditingController(text: eventData['eventDate']),
                  style: textboxStyle,
                  decoration: InputDecoration(
                    errorText: errorMessageDate,
                    contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                    hasFloatingPlaceholder: true
                  ),
                  format: DateFormat('EEEE MMMM d, yyyy.'),
                  onShowPicker: (context,currentValue) async{
                    var  date= await showDatePicker(
                        context: context,
                        initialDate: currentValue ?? DateTime.now(),
                        firstDate: DateTime(2017),
                        lastDate: DateTime(2021)
                    );
                    return date;
                  },
                  //onChanged: ,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: RaisedButton(
        onPressed: isDataEmpty ? () async{
          if (eventName.text.isEmpty){
            setState(() {
              errorMessage=validatePassword(eventName.text);
            });
          }
          else{
            DateTime eventDateConvert = DateFormat('EEEE MMMM d, yyyy.').parse(eventDate.text);
            if (eventDateConvert.isBefore(DateTime.now())){
              setState(() {
                errorMessageDate = validateDate(eventDate.text);
              });
            }
            else{
              int difference = await getDifference(eventDate.text);
              await addEvent(n: toBeginningOfSentenceCase(eventName.text), de: toBeginningOfSentenceCase(eventDescription.text), da: toBeginningOfSentenceCase(eventDate.text), du: difference);
              Navigator.pushReplacementNamed(context, '/view_event', arguments: {
                'eventName': eventName.text,
                'eventDescription': eventDescription.text,
                'eventDate': eventDate.text,
                'index': name.length-1
              });
            }
          }

        }
        : () async{
          if (eventName1.text.isEmpty){
            setState(() {
              errorMessage=validatePassword(eventName1.text);
            });
          }
          else{
            DateTime eventDateConvert = DateFormat('EEEE MMMM d, yyyy.').parse(eventDate1.text);
            if (eventDateConvert.isBefore(DateTime.now())){
            setState(() {
              errorMessageDate = validateDate(eventDate1.text);
            });
            }
            else {
              int difference1 = await getDifference(eventDate1.text);
              await updateEvent(n: toBeginningOfSentenceCase(eventName1.text),
                  de: toBeginningOfSentenceCase(eventDescription1.text),
                  da: toBeginningOfSentenceCase(eventDate1.text),
                  du: difference1,
                  index: eventData['index']);
              var update = {
                'eventName': name[eventData['index']],
                'eventDescription': eventDescription1.text,
                'eventDate': eventDate1.text,
                'index': eventData['index']
              };
              Navigator.pop(context, update);
            }
          }
        },
        child: Text(
          'Save',
          style: TextStyle(
              color: Colors.white
          ),
        ),
        color: Colors.indigo[700],
      ),
    );
  }
}

String validatePassword(value){
  if (value.isEmpty){
    return 'Event Name must not be empty.';
  }
  return null;
}

dynamic validateDate(value){
  DateTime eventDate = DateFormat('EEEE MMMM d, yyyy.').parse(value);
  if (eventDate.isBefore(DateTime.now())){
    return 'invalid Event Date';
  }
  return null;
}
