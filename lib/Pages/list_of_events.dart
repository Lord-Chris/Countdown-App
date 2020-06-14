import 'package:flutter/material.dart';
import 'package:countdown_app/services/events.dart';
import '../UI/Timer.dart';

class ListOfEvents extends StatefulWidget {
  @override
  _ListOfEventsState createState() => _ListOfEventsState();
}

class _ListOfEventsState extends State<ListOfEvents> with SingleTickerProviderStateMixin{

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
        onPressed: (){
          Navigator.pushNamed(context, '/add_events');
        },
        backgroundColor: Colors.indigo[700],
        child: Icon(Icons.add),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/light.png'), fit: BoxFit.cover),
        ),
        child:ListView.builder(
          itemCount: name.length,
          itemBuilder: (context,index) {
            if (duration[index]<0){
              deleteEvent(index);
            }
            print('imdex ix $index' );
            return Card(
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){
                        setState(() {
                          deleteEvent(index);
                       });
                    }),
                    onTap: (){
                      Navigator.pushNamed(context, '/view_event', arguments: {
                        'eventName': name[index],
                        'eventDescription': des[index],
                        'eventDate':date[index],
                        'index': index
                      });
                    },
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          name[index],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0
                          ),
                        ),
                        SizedBox(height: 3.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Days left: ',
                              style: TextStyle(
                                  fontFamily: 'fantasy',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18.0
                              ),
                            ),
                            Timer('seconds', duration[index]),
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