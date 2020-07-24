import 'package:countdown_app/app/router.dart';
import 'package:flutter/material.dart';
import 'package:countdown_app/services/events.dart';
import '../UI/Timer.dart';
import 'package:intl/intl.dart';

class ListOfEvents extends StatefulWidget {
  @override
  _ListOfEventsState createState() => _ListOfEventsState();
}

class _ListOfEventsState extends State<ListOfEvents>
    with SingleTickerProviderStateMixin {
  void loadStorage() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadStorage();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          itemCount: name.length,
          itemBuilder: (context, index) {
            //print(duration[index].inHours);
            if (duration[index].inHours < 0) {
              Events.deleteEvent(index);
            }

            // print({duration[index].inDays/7}.toString().substring(1,2));
            // print(name);
            // print(date);
            print(duration);
            return Card(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            Events.deleteEvent(index);
                          });
                        }),
                    onTap: () async {
                      await Navigator.pushNamed(context, Routes.viewEvents,
                          arguments: {
                            'eventName': name[index],
                            'eventDescription': des[index],
                            'eventDate': date[index],
                            'index': index
                          });
                      setState(() {});
                    },
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          name[index],
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
                            // Expanded(
                            //   child: TimerWidget(
                            //     title:'Wks',
                            //     dTime: duration[index].inDays / 7,
                            //     division: 24*7,
                            //     duration: Duration(days: 7),
                            //   ),
                            // ),
                            Expanded(
                              child: TimerWidget(
                                title: 'Days',
                                time: duration[index].inDays,
                                division: 24,
                                duration: Duration(days: 1),
                              ),
                            ),
                            Expanded(
                              child: TimerWidget(
                                title: 'Hours',
                                time: duration[index].inHours,
                                division: 60,
                                duration: Duration(hours: 1),
                              ),
                            ),
                            TimerWidget(
                              title: 'Secs',
                              time: duration[index].inSeconds,
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
