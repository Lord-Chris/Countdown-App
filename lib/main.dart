import 'package:flutter/material.dart';
import 'package:countdown_app/Pages/list_of_events.dart';
import 'package:countdown_app/Pages/add_events.dart';
import 'package:countdown_app/Pages/view_event.dart';



void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => ListOfEvents(),
    '/view_event':(context) => ViewEvent(),
    '/add_events':(context) => AddEvent(),
  },
));


