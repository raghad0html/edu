import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class BotProvider with ChangeNotifier {
  Map<String, dynamic> _allSteps = {};
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> loadKnowledgeBase() async {
    final String response = await rootBundle.loadString('assets/troubleshooting.json');
    final data = await json.decode(response);
    _allSteps = data['steps'];
    _isLoading = false;
    notifyListeners();
  }

  Map<String, dynamic>? getStep(String id) => _allSteps[id];
}