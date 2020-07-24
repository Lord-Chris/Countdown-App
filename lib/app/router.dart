import 'package:countdown_app/Pages/add_events.dart';
import 'package:countdown_app/Pages/list_of_events.dart';
import 'package:countdown_app/Pages/view_event.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static const listOfEventsRoute = '/';
  static const addEvent = '/addEvents';
  static const viewEvents = '/viewEvents';
}

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.listOfEventsRoute:
        return MaterialPageRoute(
            builder: (context) => ListOfEvents(), settings: settings);
        break;
      case Routes.addEvent:
        dynamic data = settings.arguments ?? {};
        dynamic name = data['eventName'] ?? '';
        dynamic desc = data['eventDescription'] ?? '';
        dynamic date = data['eventDate'];
        int index = data['index'];
        return MaterialPageRoute(
            builder: (context) => AddEvent(
                  eventName: name,
                  eventDate: date,
                  eventDesc: desc,
                  index: index,
                ),
            settings: settings);
        break;
      case Routes.viewEvents:
        dynamic data = settings.arguments;
        String name = data['eventName'];
        String desc = data['eventDescription'];
        dynamic date = data['eventDate'];
        int index = data['index'];
        print('I amde my data $data');
        return MaterialPageRoute(
            builder: (context) => ViewEvent(
              eventName: name,
              eventDesc: desc,
              eventDate: date,
              index: index,
            ), settings: settings);
        break;
      default:
        errorPageRoute(settings.name);
    }
  }
}

MaterialPageRoute errorPageRoute(String routeName) =>
    MaterialPageRoute(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Text(
            routeName == "/"
                ? 'Initial route not found! \n did you forget to annotate your home page with @initial or @MaterialRoute(initial:true)?'
                : 'Route name $routeName is not found!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    });
