import 'package:countdown_app/app/router.dart';
import 'package:flutter/material.dart';
import 'package:countdown_app/Pages/list_of_events.dart';
import 'package:countdown_app/Pages/add_events.dart';
import 'package:countdown_app/Pages/view_event.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Router().onGenerateRoute,
      initialRoute: Routes.listOfEventsRoute,
    );
  }
}
