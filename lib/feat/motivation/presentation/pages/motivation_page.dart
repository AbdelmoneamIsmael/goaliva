import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/motivation_cubit.dart';
import '../models/motivation_models.dart';
import '../widgets/motivation_add_button.dart';
import '../widgets/motivation_featured_card.dart';
import '../widgets/motivation_topic_section.dart';
import 'motivation_topic_page.dart';

class MotivationPage extends StatelessWidget {
  const MotivationPage({super.key});

  void _onAddPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('motivation.add_coming_soon'.tr()),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _openTopic(
    BuildContext context,
    MotivationTopic topic,
    Color accent,
  ) async {
    final cubit = context.read<MotivationCubit>();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: MotivationTopicPage(
            topicId: topic.id,
            accent: accent,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<MotivationCubit, MotivationState>(
      builder: (context, state) {
        final cubit = context.read<MotivationCubit>();
        final featured = state.featuredQuote;

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
                  topicLabel: state.featuredTopicTitleKey.tr(),
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
                MotivationAddButton(onPressed: () => _onAddPressed(context)),
                SizedBox(height: 14.h),
                ...state.topics.map((topic) {
                  final accent = cubit.accentFor(topic.id, isDark, colorScheme);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MotivationTopicSection(
                      topic: topic,
                      accent: accent,
                      onTap: () => _openTopic(context, topic, accent),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
