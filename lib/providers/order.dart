import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  TabController tabCtrl;
  String _selectedProject;
  String _selectedBatchPlant;

  String get selectedProject => _selectedProject;

  String get selectedBatchPlant => _selectedBatchPlant;

  set selectedProject(String v) {
    _selectedProject = v;
    notifyListeners();
  }

  set selectedBatchPlant(String v) {
    _selectedBatchPlant = v;
    notifyListeners();
  }

  void nextPage(int delta) {
    final int newIndex = tabCtrl.index + delta;
    if (newIndex < 0 || newIndex >= tabCtrl.length) return;
    tabCtrl.animateTo(newIndex);
    notifyListeners();
  }
}
