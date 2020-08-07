List<String> name = [];
List<String> des = [];
List<DateTime> date = [];
List<Duration> duration = [];

class Event {
  String name;
  String description;
  DateTime date;

  Event({this.name, this.description, this.date});
  
  set duration(_date) {
    _date = date;
  }

  Duration get duration => date.difference(DateTime.now());

  set newName(String newName) => name = newName;
  set newDescription(String desc) => description = desc;
  set newDate(DateTime newDate) => date = newDate;
}

class Events {
  static List<Event> events = [];

  void addEvent(Event event) {
    events.add(event);
  }

  void updateEvent(Event event, int index) {
    events[index] = event;
  }

  void deleteEvent(int index) {
    events.removeAt(index);
  }

  int getIndex() {
    int index = events.length;
    return index;
  }
}


//  for (int _event in    .events) {
//       if (_event.duration.inSeconds == 0 ||
//           _event.date.isBefore(DateTime.now())) {
//         showDialog(
//           context: context,
//           child: AlertDialog(
//             title: Container(
//               width: double.maxFinite,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//               ),
//               child: Center(
//                 child: Column(
//                   children: <Widget>[
//                     CircleAvatar(
//                       radius: 100,
//                       child: Icon(
//                         Icons.event_available,
//                         size: 150,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'What would you like to do with this reminder?',
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 40),
//                     Row(
//                       children: <Widget>[
//                         Container(
//                           width: 110,
//                           child: FlatButton(
//                             onPressed: () {
//                               Events().deleteEvent(_event);
//                               Navigator.pop(context);
//                             },
//                             color: Colors.indigo,
//                             child: Text(
//                               'Delete \n Event',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Container(
//                           width: 110,
//                           child: FlatButton(
//                             color: Colors.indigo,
//                             onPressed: () {
//                               // Navigator.pushReplacementNamed(
//                               //     context, Routes.addEvent,
//                               //     arguments: index);
//                             },
//                             child: Text(
//                               'Reschedule Event',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         );
//       }
//     }



// deletePage() {
//   return Scaffold(
//     appBar: AppBar(
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () {},
//       ),
//       title: Text('Select Events to delete'),
//       actions: <Widget>[
//         IconButton(
//           icon: Icon(Icons.delete_forever),
//           onPressed: () {},
//         )
//       ],
//     ),
//     body: Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/light.png'), fit: BoxFit.cover),
//       ),
//       child: ListView.builder(
//         itemCount: name.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: Column(
//               children: <Widget>[
//                 ListTile(
//                   leading: IconButton(
//                     icon: Checkbox(),
//                   ),
//                   title: Text(
//                     name[index],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }

/*

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {


  var done = [];
  var data= [];
  TextEditingController newTodo = TextEditingController();
  TextStyle style = TextStyle(
      fontStyle: FontStyle.italic
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        primary: true,
        reverse: false,
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Text('Add Todo'),
            TextField(
              controller: newTodo,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                hasFloatingPlaceholder: true,
                labelText: 'Event name',
                border: OutlineInputBorder(
                  //borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      data.add(newTodo.text);
                      //newTodo= new TextEditingController();
                    });
                  },
                  icon: Icon(Icons.add),
                  label: Text('ADD'),
                ),
              ],
            ),
            Text('Todos'),
            ListView.builder(shrinkWrap: true,
              itemCount: data.length,
              itemBuilder:(context,index){
                return ListTile(
                  onTap: (){},
                  title: Text(
                    data[index],
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        data.remove(data[index]);
                      });
                    },
                    child: Icon(Icons.delete),
                  ),
                  leading: GestureDetector(
                    onTap: (){
                      setState(() {
                        done.add(data[index]);
                        data.remove(data[index]);
                      });
                    },
                    child: Icon(Icons.done),
                  ),
                );
              },
            ),
            Text('Done Todos'),
            ListView.builder(
              itemCount: done.length,
              shrinkWrap: true,
              itemBuilder:(context, index){
                return SingleChildScrollView(
                  child: Card(
                    elevation: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:13.0),
                          child: Text(
                            done[index],
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.undo),
                          onPressed: (){
                            setState(() {
                              data.add(data[index]);
                              done.remove(data[index]);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

*/
