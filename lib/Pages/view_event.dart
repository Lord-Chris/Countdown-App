import 'package:countdown_app/UI/Timer.dart';
import 'package:countdown_app/app/router.dart';
import 'package:flutter/material.dart';
import 'package:countdown_app/services/events.dart';
import 'package:intl/intl.dart';

class ViewEvent extends StatefulWidget {
  final int index;

  const ViewEvent({Key key, this.index}) : super(key: key);

  @override
  _ViewEventState createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  @override
  Widget build(BuildContext context) {
    DateFormat _eventFormat = DateFormat('EEEE MMMM d, yyyy.');
    int _index = widget.index;
    String _eventDate = _eventFormat.format(Events.events[_index].date);
    DateTime _time = Events.events[_index].date;
    dynamic _duration = Events.events[_index].duration;

    return WillPopScope(
      onWillPop: () async{
        Navigator.pushNamedAndRemoveUntil(context,Routes.listOfEventsRoute, (Route<dynamic> route) => false);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.indigo[700],
          title: Text('My Event'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () async {
                  Navigator.pushReplacementNamed(context, Routes.addEvent,
                      arguments: _index
                      // {
                      // 'eventName': name[_index],
                      // 'eventDescription': des[_index],
                      // 'eventDate': date[_index],
                      // 'index': _index
                      // }
                      );
                  // setState(() {
                  //   // newData = {
                  //   //   'eventName': result['eventName'],
                  //   //   'eventDescription': result['eventDescription'],
                  //   //   'eventDate': result['eventDate']
                  //   // };
                  //   // //print('oldDuran ffffis ${duration[index]}');
                  //   //int stuff = await Events.getDifference(newData['eventDate']);
                  //   //duration[index] = stuff;
                  //   //print('newDuran vvvvvis ${duration[index]}');
                  // });
                },
                icon: Icon(Icons.edit),
              ),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/light.png'), fit: BoxFit.cover),
          ),
          child: Card(
            elevation: 0.0,
            margin: EdgeInsets.all(10.0),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Text('Event Name:'),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 70,
                      child: Text(
                        Events.events[_index].name,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(fontSize: 36.0, color: Colors.black),
                      ),
                    ),
                    Divider(
                      height: 50,
                      color: Colors.grey,
                    ),
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 70,
                      child: Text(
                        Events.events[_index].description,
                        maxLines: 15,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style:
                            TextStyle(fontSize: 25.0, color: Colors.grey[900]),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      _eventDate,
                      style: TextStyle(fontSize: 25.0, color: Colors.grey[850]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Time left: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'fantasy',
                            fontStyle: FontStyle.italic,
                            fontSize: 18.0,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: TimerWidget(
                            title: 'Wks',
                            dTime: Events.events[_index].date.difference(DateTime.now()).inDays,
                            division: 168,
                            duration: Duration(days: 7),
                          ),
                        ),
                        Expanded(
                          child: TimerWidget(
                            title: 'Days',
                            time: Events.events[_index].duration.inDays,
                            division: 24,
                            duration: Duration(days: 1),
                          ),
                        ),
                        Expanded(
                          child: TimerWidget(
                            title: 'Hrs',
                            time: Events.events[_index].duration.inHours,
                            division: 60,
                            duration: Duration(hours: 1),
                          ),
                        ),
                        TimerWidget(
                          title: 'Secs',
                          time: Events.events[_index].duration.inSeconds,
                          division: 60,
                          duration: Duration(seconds: 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
