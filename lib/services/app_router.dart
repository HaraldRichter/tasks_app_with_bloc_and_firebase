import 'package:flutter/material.dart';
import 'package:tasks_app_with_bloc_and_firebase/screens/recycle_bin.dart';

import '../screens/tasks_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        // Anstatt von 'RecycleBin.id' hätten wir auch direkt 'recycle_bin' als
        // String schreiben können; die Methode, dies nicht zu tun und stattdessen
        // eine Variable aufzurufen, hat den Vorteil, dass man nicht Gefahr läuft,
        // Tippfehler zu machen.
        return MaterialPageRoute(builder: (_) => RecycleBin());
      case TasksScreen.id:
        return MaterialPageRoute(builder: (_) => TasksScreen());
      default:
        return null;
    }
  }
}
