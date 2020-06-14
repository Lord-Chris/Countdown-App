import 'package:flutter/material.dart';
import 'package:countdown_app/services/events.dart';



class ViewEvent extends StatefulWidget {
  @override
  _ViewEventState createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {

  Map newData;

  @override
  Widget build(BuildContext context) {

    newData = ModalRoute.of(context).settings.arguments;
    int index=newData['index'];
    /*print('oldDuran is ${duration[index]}');
    Duration stuff = getDifference(newData['eventDate']);
    duration[index]= stuff.inDays;
    print('newDuran is ${duration[index]}');*/



    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: Text('My Event'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed:()async{
                dynamic result = await Navigator.pushNamed(context, '/add_events', arguments: {
                'eventName': name[index],
                'eventDescription': des[index],
                'eventDate': date[index],
                'index': index
                });

                setState(() {
                newData= {
                'eventName': result['eventName'],
                'eventDescription': result['eventDescription'],
                'eventDate': result['eventDate']
                };
                print('oldDuran ffffis ${duration[index]}');
                int stuff = getDifference(newData['eventDate']);
                duration[index]= stuff;
                print('newDuran vvvvvis ${duration[index]}');
                });
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
          image: DecorationImage(image: AssetImage('assets/light.png'), fit: BoxFit.cover),
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
                  SizedBox(height: 10.0,),
                  Container(
                    width: MediaQuery.of(context).size.width-70,
                    child: Text(
                      name[index],
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 36.0,
                        color: Colors.black
                      ),
                    ),
                  ),
                  Divider(height: 50,color: Colors.grey,),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    width: MediaQuery.of(context).size.width-70,
                    child: Text(
                      des[index],
                      maxLines: 15,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.grey[900]
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  Text(
                    'Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    date[index],
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.grey[850]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
