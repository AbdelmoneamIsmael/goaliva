import 'package:flutter/material.dart';

class MotivationQuote {
  MotivationQuote({
    required this.id,
    required this.text,
  });

  final String id;
  String text;
}

class MotivationTopic {
  MotivationTopic({
    required this.id,
    required this.titleKey,
    required this.icon,
    required this.quotes,
  });

  final String id;
  final String titleKey;
  final IconData icon;
  final List<MotivationQuote> quotes;
}
