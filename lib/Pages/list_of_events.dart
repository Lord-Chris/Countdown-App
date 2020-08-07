import 'package:countdown_app/app/router.dart';
import 'package:flutter/material.dart';
import 'package:countdown_app/services/events.dart';
import '../UI/Timer.dart';

class ListOfEvents extends StatefulWidget {
  @override
  _ListOfEventsState createState() => _ListOfEventsState();
}

class _ListOfEventsState extends State<ListOfEvents> {
  //TODO: Imlement pop uo dialog and notification
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        elevation: 0.0,
        title: Text('My Events'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addEvent);
        },
        backgroundColor: Colors.indigo[700],
        child: Icon(Icons.add),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/light.png'), fit: BoxFit.cover),
        ),
        child: ListView.builder(
          itemCount: Events.events.length,
          itemBuilder: (context, index) {
            //_reload ? reload() : print('object');
            //print(duration[index].inHours);
            // if (duration[index].inHours < 0) {
            //   Events().deleteEvent2(index);
            // } //TODO: implement correct delete function

            // print(date);
            //print(Events.events[index].duration.inDays);
            return Card(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            Events().deleteEvent(index);
                          });
                        }),
                    onTap: () async {
                      Navigator.pushNamed(context, Routes.viewEvents,
                          arguments: index);
                    },
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          Events.events[index].name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 3.0,
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
                                dTime: Events.events[index].duration.inDays,
                                division: 168,
                                duration: Duration(days: 7),
                              ),
                            ),
                            Expanded(
                              child: TimerWidget(
                                title: 'Days',
                                time: Events.events[index].duration.inDays,
                                division: 24,
                                duration: Duration(days: 1),
                              ),
                            ),
                            Expanded(
                              child: TimerWidget(
                                title: 'Hrs',
                                time: Events.events[index].duration.inHours,
                                division: 60,
                                duration: Duration(hours: 1),
                              ),
                            ),
                            TimerWidget(
                              title: 'Secs',
                              time: Events.events[index].duration.inSeconds,
                              division: 60,
                              duration: Duration(seconds: 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
