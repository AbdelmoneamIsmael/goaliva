import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/confirm_action_dialog.dart';
import '../cubit/motivation_cubit.dart';
import '../models/motivation_models.dart';
import '../widgets/motivation_quote_card.dart';

class MotivationTopicPage extends StatelessWidget {
  const MotivationTopicPage({
    super.key,
    required this.topicId,
    required this.accent,
  });

  final String topicId;
  final Color accent;

  Future<void> _editQuote(
    BuildContext context,
    MotivationTopic topic,
    MotivationQuote quote,
  ) async {
    final controller = TextEditingController(text: quote.text);
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (sheetContext) {
        final bottomInset = MediaQuery.viewInsetsOf(sheetContext).bottom;
        final theme = Theme.of(sheetContext);

        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            20.w,
            16.h,
            20.w,
            20.h + bottomInset,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'motivation.edit_title'.tr(),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                topic.titleKey.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: controller,
                hint: 'motivation.edit_hint'.tr(),
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),
              SizedBox(height: 20.h),
              AppButton(
                label: 'motivation.save'.tr(),
                onPressed: () {
                  final next = controller.text.trim();
                  if (next.isEmpty) return;
                  Navigator.of(sheetContext).pop(true);
                },
              ),
            ],
          ),
        );
      },
    );

    if (saved == true && context.mounted) {
      context.read<MotivationCubit>().updateQuote(
            topicId: topic.id,
            quoteId: quote.id,
            text: controller.text,
          );
    }
    controller.dispose();
  }

  Future<void> _deleteQuote(
    BuildContext context,
    MotivationTopic topic,
    MotivationQuote quote,
  ) async {
    final confirmed = await ConfirmActionDialog.show(
      context,
      titleKey: 'motivation.delete_title',
      messageKey: 'motivation.delete_message',
      cancelLabelKey: 'common.cancel',
      confirmLabelKey: 'common.remove',
    );
    if (!confirmed || !context.mounted) return;

    context.read<MotivationCubit>().deleteQuote(
          topicId: topic.id,
          quoteId: quote.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<MotivationCubit, MotivationState>(
      builder: (context, state) {
        final topic = state.topicById(topicId);
        if (topic == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('motivation.empty_topic'.tr()),
            ),
          );
        }

        final quotes = topic.quotes;

        return Scaffold(
          appBar: AppBar(
            title: Text(topic.titleKey.tr()),
          ),
          body: quotes.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                      'motivation.empty_topic'.tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.w, 12.h, 20.w, 28.h),
                  itemCount: quotes.length + 1,
                  separatorBuilder: (_, _) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Text(
                        'motivation.quote_count'.tr(
                          namedArgs: {'count': '${quotes.length}'},
                        ),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }

                    final quote = quotes[index - 1];
                    return MotivationQuoteCard(
                      quote: quote,
                      accent: accent,
                      onEdit: () => _editQuote(context, topic, quote),
                      onDelete: () => _deleteQuote(context, topic, quote),
                    );
                  },
                ),
        );
      },
    );
  }
}
