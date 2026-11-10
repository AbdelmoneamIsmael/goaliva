import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import 'cubit/alarm_form_cubit.dart';

class AlarmFormSheet extends StatefulWidget {
  const AlarmFormSheet({super.key, required this.onSave});

  final ValueChanged<AlarmFormResult> onSave;

  static Future<bool> show(
    BuildContext context, {
    String? id,
    String title = '',
    String description = '',
    int? hour,
    int? minute,
    bool repeats = false,
    required ValueChanged<AlarmFormResult> onSave,
  }) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (sheetContext) {
        return BlocProvider(
          create: (_) => AlarmFormCubit(
            id: id,
            title: title,
            description: description,
            hour: hour,
            minute: minute,
            repeats: repeats,
          ),
          child: AlarmFormSheet(onSave: onSave),
        );
      },
    );

    return saved == true;
  }

  @override
  State<AlarmFormSheet> createState() => _AlarmFormSheetState();
}

class _AlarmFormSheetState extends State<AlarmFormSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final state = context.read<AlarmFormCubit>().state;
    _titleController = TextEditingController(text: state.title);
    _descriptionController = TextEditingController(text: state.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final formCubit = context.read<AlarmFormCubit>();
    final current = formCubit.state;
    final initial = current.hasTime
        ? TimeOfDay(hour: current.hour!, minute: current.minute!)
        : TimeOfDay.now();

    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null || !mounted) return;
    formCubit.setTime(hour: picked.hour, minute: picked.minute);
  }

  void _onSave() {
    final result = context.read<AlarmFormCubit>().validate();
    if (result == null) return;
    widget.onSave(result);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        20.w,
        16.h,
        20.w,
        20.h + bottomInset,
      ),
      child: BlocBuilder<AlarmFormCubit, AlarmFormState>(
        builder: (context, state) {
          final errors = state.fieldErrors;
          final timeLabel = state.hasTime
              ? TimeOfDay(
                  hour: state.hour!,
                  minute: state.minute!,
                ).format(context)
              : 'alarm.time_hint'.tr();

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  (state.isEditing ? 'alarm.edit_title' : 'alarm.add_title')
                      .tr(),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'alarm.form_subtitle'.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 20.h),
                AppTextFieldWithTitle(
                  title: 'alarm.field_title'.tr(),
                  hint: 'alarm.field_title_hint'.tr(),
                  controller: _titleController,
                  isRequired: true,
                  textInputAction: TextInputAction.next,
                  onChanged: context.read<AlarmFormCubit>().setTitle,
                ),
                if (errors.titleKey != null) ...[
                  SizedBox(height: 6.h),
                  _FieldErrorText(messageKey: errors.titleKey!),
                ],
                SizedBox(height: 16.h),
                AppTextFieldWithTitle(
                  title: 'alarm.field_description'.tr(),
                  hint: 'alarm.field_description_hint'.tr(),
                  controller: _descriptionController,
                  isRequired: false,

                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  helperText: 'alarm.field_description_helper'.tr(),
                  onChanged: context.read<AlarmFormCubit>().setDescription,
                ),

                SizedBox(height: 16.h),
                Text(
                  'alarm.field_time'.tr(),
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 11.h),
                InkWell(
                  onTap: _pickTime,
                  borderRadius: BorderRadius.circular(12.r),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorScheme.surface,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: colorScheme.outline.withValues(alpha: 0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.access_time_rounded,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    child: Text(
                      timeLabel,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: state.hasTime
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                if (errors.timeKey != null) ...[
                  SizedBox(height: 6.h),
                  _FieldErrorText(messageKey: errors.timeKey!),
                ],
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.35),
                    ),
                  ),
                  child: SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'alarm.field_repeat'.tr(),
                      style: theme.textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      'alarm.field_repeat_sub'.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    value: state.repeats,
                    onChanged: context.read<AlarmFormCubit>().setRepeats,
                  ),
                ),
                SizedBox(height: 24.h),
                AppButton(label: 'alarm.save'.tr(), onPressed: _onSave),
                SizedBox(height: 8.h),
                AppButton(
                  label: 'common.cancel'.tr(),
                  variant: AppButtonVariant.tertiary,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FieldErrorText extends StatelessWidget {
  const _FieldErrorText({required this.messageKey});

  final String messageKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      messageKey.tr(),
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.error,
      ),
    );
  }
}
