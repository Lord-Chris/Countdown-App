import 'package:countdown_app/app/router.dart';
import 'package:flutter/material.dart';
import 'package:countdown_app/Pages/list_of_events.dart';
import 'package:countdown_app/Pages/add_events.dart';
import 'package:countdown_app/Pages/view_event.dart';



void main() => runApp(MaterialApp(
  onGenerateRoute: Router().onGenerateRoute,
  initialRoute: Routes.listOfEventsRoute,
));


