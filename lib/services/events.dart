import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
List name = [];
List des = [];
List date = [];
List duration = [];


getDifference(a) {
  DateTime eventDate = DateFormat('EEEE MMMM d, yyyy.').parse(a);
  DateTime currentDate = DateTime.now();
  Duration difference = eventDate.difference(currentDate);
  return difference.inMinutes;
}

addEvent({n, de, da, du, index}) {
  name.add(n);
  des.add(de);
  date.add(da);
  duration.add(du);
  //print(name.length);
}
updateEvent({n, de, da, du, index}){
  name[index] = n;
  des[index] = de;
  date[index] = da;
  duration[index]= du;
  //print('$name, $des, $date, $index');
}

deleteEvent(index){
  name.remove(name[index]);
  des.remove(des[index]);
  date.remove(date[index]);
  duration.remove(duration[index]);
}

getIndex({n}){
  int index;
  index = name.length;
  print(index);
}



deletePage(){
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){},
      ),
      title: Text('Select Events to delete'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: (){},
        )
      ],
    ),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/light.png'), fit: BoxFit.cover),
      ),
      child: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context,index){
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: IconButton(
                    icon: Checkbox(),
                  ),
                  title: Text(
                    name[index],
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
