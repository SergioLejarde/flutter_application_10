import 'package:flutter/material.dart';

class ViewProvider with ChangeNotifier {
  bool _isGridView = false;

  bool get isGridView => _isGridView;

  void toggleView() {
    _isGridView = !_isGridView;
    notifyListeners();
  }
}
