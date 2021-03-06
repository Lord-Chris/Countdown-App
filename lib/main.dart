import 'package:countdown_app/app/router.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Router().onGenerateRoute,
      initialRoute: Routes.listOfEventsRoute,
    );
  }
}
