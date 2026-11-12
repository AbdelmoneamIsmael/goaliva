import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/motivation_models.dart';

part 'motivation_state.freezed.dart';

@freezed
abstract class MotivationState with _$MotivationState {
  const MotivationState._();

  const factory MotivationState({
    required List<MotivationTopic> topics,
  }) = _MotivationState;

  MotivationQuote get featuredQuote {
    for (final topic in topics) {
      if (topic.quotes.isNotEmpty) return topic.quotes.first;
    }
    return MotivationQuote(
      id: 'fallback',
      text: 'motivation.featured_fallback'.tr(),
    );
  }

  String get featuredTopicTitleKey {
    for (final topic in topics) {
      if (topic.quotes.isNotEmpty) return topic.titleKey;
    }
    return 'motivation.title';
  }

  MotivationTopic? topicById(String id) {
    for (final topic in topics) {
      if (topic.id == id) return topic;
    }
    return null;
  }
}
