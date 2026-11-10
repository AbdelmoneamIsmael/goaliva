import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/view/alarm_form/alarm_form_sheet.dart';
import '../../../../core/view/alarm_form/cubit/alarm_form_state.dart';
import '../../../../core/widgets/confirm_action_dialog.dart';
import '../../../../core/widgets/custom_empty_widgets.dart';
import '../cubit/alarm_cubit.dart';
import '../models/alarm.dart';
import '../widgets/alarm_card.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  Future<void> _openForm(BuildContext context, {Alarm? alarm}) async {
    final alarmCubit = context.read<AlarmCubit>();

    await AlarmFormSheet.show(
      context,
      id: alarm?.id,
      title: alarm?.title ?? '',
      description: alarm?.description ?? '',
      hour: alarm?.hour,
      minute: alarm?.minute,
      repeats: alarm?.repeats ?? false,
      onSave: (AlarmFormResult result) {
        if (result.id == null) {
          alarmCubit.addAlarm(
            Alarm(
              id: 'alarm_${DateTime.now().millisecondsSinceEpoch}',
              title: result.title,
              description: result.description,
              hour: result.hour,
              minute: result.minute,
              repeats: result.repeats,
              enabled: true,
            ),
          );
          return;
        }

        final existing = alarmCubit.state.alarms.firstWhere(
          (item) => item.id == result.id,
        );
        alarmCubit.updateAlarm(
          existing.copyWith(
            title: result.title,
            description: result.description,
            hour: result.hour,
            minute: result.minute,
            repeats: result.repeats,
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, Alarm alarm) async {
    final confirmed = await ConfirmActionDialog.show(
      context,
      titleKey: 'alarm.delete_title',
      messageKey: 'alarm.delete_message',
      cancelLabelKey: 'common.cancel',
      confirmLabelKey: 'common.remove',
    );
    if (!confirmed || !context.mounted) return;
    context.read<AlarmCubit>().deleteAlarm(alarm.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<AlarmCubit, AlarmState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('alarm.title'.tr()), centerTitle: false),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _openForm(context),
            tooltip: 'alarm.add'.tr(),
            child: const Icon(Icons.add_rounded),
          ),
          body: SafeArea(
            child: state.alarms.isEmpty
                ? EmptyWidget(
                    icon: Icons.alarm_off_rounded,
                    title: 'alarm.empty_title'.tr(),
                    description: 'alarm.empty_description'.tr(),
                    accentColor: colorScheme.primary,
                  )
                : ListView(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      20.w,
                      12.h,
                      20.w,
                      100.h,
                    ),
                    children: [
                      Text(
                        'alarm.subtitle'.tr(),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'alarm.active_count'.tr(
                          namedArgs: {'count': '${state.activeCount}'},
                        ),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      ...state.alarms.map((alarm) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: AlarmCard(
                            alarm: alarm,
                            onToggle: (_) => context
                                .read<AlarmCubit>()
                                .toggleEnabled(alarm.id),
                            onEdit: () => _openForm(context, alarm: alarm),
                            onDelete: () => _confirmDelete(context, alarm),
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
