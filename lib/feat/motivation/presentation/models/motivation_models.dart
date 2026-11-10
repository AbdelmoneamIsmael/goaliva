import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MotivationQuote extends Equatable {
  const MotivationQuote({
    required this.id,
    required this.text,
  });

  final String id;
  final String text;

  MotivationQuote copyWith({String? text}) {
    return MotivationQuote(
      id: id,
      text: text ?? this.text,
    );
  }

  @override
  List<Object?> get props => [id, text];
}

class MotivationTopic extends Equatable {
  const MotivationTopic({
    required this.id,
    required this.titleKey,
    required this.icon,
    required this.quotes,
  });

  final String id;
  final String titleKey;
  final IconData icon;
  final List<MotivationQuote> quotes;

  MotivationTopic copyWith({List<MotivationQuote>? quotes}) {
    return MotivationTopic(
      id: id,
      titleKey: titleKey,
      icon: icon,
      quotes: quotes ?? this.quotes,
    );
  }

  @override
  List<Object?> get props => [id, titleKey, icon, quotes];
}
