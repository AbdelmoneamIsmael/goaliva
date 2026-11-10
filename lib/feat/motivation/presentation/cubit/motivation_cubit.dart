import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../models/motivation_models.dart';

class MotivationState extends Equatable {
  const MotivationState({required this.topics});

  final List<MotivationTopic> topics;

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

  @override
  List<Object?> get props => [topics];
}

class MotivationCubit extends Cubit<MotivationState> {
  MotivationCubit() : super(MotivationState(topics: buildSampleTopics()));

  static List<MotivationTopic> buildSampleTopics() {
    return [
      MotivationTopic(
        id: 'medicine',
        titleKey: 'motivation.topics.medicine',
        icon: Icons.medication_rounded,
        quotes: [
          MotivationQuote(
            id: 'med_1',
            text: 'motivation.quotes.medicine_1'.tr(),
          ),
          MotivationQuote(
            id: 'med_2',
            text: 'motivation.quotes.medicine_2'.tr(),
          ),
          MotivationQuote(
            id: 'med_3',
            text: 'motivation.quotes.medicine_3'.tr(),
          ),
        ],
      ),
      MotivationTopic(
        id: 'movement',
        titleKey: 'motivation.topics.movement',
        icon: Icons.directions_run_rounded,
        quotes: [
          MotivationQuote(
            id: 'move_1',
            text: 'motivation.quotes.movement_1'.tr(),
          ),
          MotivationQuote(
            id: 'move_2',
            text: 'motivation.quotes.movement_2'.tr(),
          ),
        ],
      ),
      MotivationTopic(
        id: 'focus',
        titleKey: 'motivation.topics.focus',
        icon: Icons.center_focus_strong_rounded,
        quotes: [
          MotivationQuote(
            id: 'focus_1',
            text: 'motivation.quotes.focus_1'.tr(),
          ),
          MotivationQuote(
            id: 'focus_2',
            text: 'motivation.quotes.focus_2'.tr(),
          ),
        ],
      ),
    ];
  }

  Color accentFor(String topicId, bool isDark, ColorScheme scheme) {
    return switch (topicId) {
      'medicine' => isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
      'movement' =>
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
      _ => scheme.primary,
    };
  }

  void updateQuote({
    required String topicId,
    required String quoteId,
    required String text,
  }) {
    final next = text.trim();
    if (next.isEmpty) return;

    final topics = state.topics.map((topic) {
      if (topic.id != topicId) return topic;
      return topic.copyWith(
        quotes: topic.quotes
            .map(
              (quote) =>
                  quote.id == quoteId ? quote.copyWith(text: next) : quote,
            )
            .toList(),
      );
    }).toList();

    emit(MotivationState(topics: topics));
  }

  void deleteQuote({
    required String topicId,
    required String quoteId,
  }) {
    final topics = state.topics.map((topic) {
      if (topic.id != topicId) return topic;
      return topic.copyWith(
        quotes: topic.quotes.where((quote) => quote.id != quoteId).toList(),
      );
    }).toList();

    emit(MotivationState(topics: topics));
  }
}
