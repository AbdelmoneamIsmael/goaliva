import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../models/motivation_models.dart';
import '../widgets/motivation_add_button.dart';
import '../widgets/motivation_featured_card.dart';
import '../widgets/motivation_topic_section.dart';
import 'motivation_topic_page.dart';

class MotivationPage extends StatefulWidget {
  const MotivationPage({super.key});

  @override
  State<MotivationPage> createState() => _MotivationPageState();
}

class _MotivationPageState extends State<MotivationPage> {
  late List<MotivationTopic> _topics;

  @override
  void initState() {
    super.initState();
    _topics = _buildSampleTopics();
  }

  List<MotivationTopic> _buildSampleTopics() {
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

  Color _accentFor(String topicId, bool isDark, ColorScheme scheme) {
    return switch (topicId) {
      'medicine' => isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
      'movement' =>
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
      _ => scheme.primary,
    };
  }

  MotivationQuote get _featuredQuote {
    for (final topic in _topics) {
      if (topic.quotes.isNotEmpty) return topic.quotes.first;
    }
    return MotivationQuote(
      id: 'fallback',
      text: 'motivation.featured_fallback'.tr(),
    );
  }

  String get _featuredTopicLabel {
    for (final topic in _topics) {
      if (topic.quotes.isNotEmpty) return topic.titleKey.tr();
    }
    return 'motivation.title'.tr();
  }

  Future<void> _onAddPressed() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('motivation.add_coming_soon'.tr()),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _openTopic(MotivationTopic topic, Color accent) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MotivationTopicPage(
          topic: topic,
          accent: accent,
        ),
      ),
    );
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final featured = _featuredQuote;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 20.w, 28.h),
          children: [
            Text(
              'motivation.title'.tr(),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'motivation.subtitle'.tr(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            MotivationFeaturedCard(
              quote: featured.text,
              topicLabel: _featuredTopicLabel,
            ),
            SizedBox(height: 24.h),
            Text(
              'motivation.topics_label'.tr(),
              style: theme.textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            MotivationAddButton(onPressed: _onAddPressed),
            SizedBox(height: 14.h),
            ..._topics.map((topic) {
              final accent = _accentFor(topic.id, isDark, colorScheme);
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: MotivationTopicSection(
                  topic: topic,
                  accent: accent,
                  onTap: () => _openTopic(topic, accent),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
