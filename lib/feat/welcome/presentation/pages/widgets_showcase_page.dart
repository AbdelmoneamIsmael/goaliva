import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown_widget.dart';
import '../../../../core/widgets/app_link_rich_text.dart';
import '../../../../core/widgets/app_search_text_field.dart';
import '../../../../core/widgets/app_search_text_field_with_filter.dart';
import '../../../../core/widgets/app_section_header.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_toggle_selection.dart';
import '../../../../core/widgets/confirm_action_dialog.dart';
import '../../../../core/widgets/custom_empty_widgets.dart';
import '../../../../core/widgets/custom_glass_container.dart';
import '../../../../core/widgets/filter_select_widget.dart';
import '../../../../core/widgets/interest_chip.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/pagination_widget.dart';
import '../../../../core/widgets/rounded_icon_button.dart';

/// Interactive samples of shared Goaliva widgets.
class WidgetsShowcasePage extends StatefulWidget {
  const WidgetsShowcasePage({super.key});

  @override
  State<WidgetsShowcasePage> createState() => _WidgetsShowcasePageState();
}

class _WidgetsShowcasePageState extends State<WidgetsShowcasePage> {
  final _taskController = TextEditingController();
  final _searchController = TextEditingController();

  int _toggleIndex = 0;
  int _page = 1;
  String? _selectedCollection;
  final Set<String> _selectedChips = {'Focus'};
  bool _filterActive = false;
  bool _habitFilter = true;

  static const _collections = ['Focus', 'Fitness', 'Study', 'Mindset'];

  @override
  void dispose() {
    _taskController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('showcase.title'.tr()),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 32.h),
        children: [
          AppSectionHeader(title: 'showcase.section_inputs'),
          SizedBox(height: 16.h),
          AppTextFieldWithTitle(
            title: 'showcase.task_title'.tr(),
            hint: 'showcase.task_hint'.tr(),
            controller: _taskController,
            isRequired: true,
            helperText: 'showcase.task_helper'.tr(),
          ),
          SizedBox(height: 16.h),
          AppSearchTextFieldWithFilter(
            controller: _searchController,
            hint: 'showcase.search_hint'.tr(),
            isFilterActive: _filterActive,
            onFilterTap: () => setState(() => _filterActive = !_filterActive),
            onChanged: (_) {},
          ),
          SizedBox(height: 12.h),
          AppSearchTextField(
            hint: 'common.search_hint'.tr(),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 16.h),
          CustomDropdown<String>(
            items: _collections,
            value: _selectedCollection,
            hint: 'showcase.dropdown_hint'.tr(),
            itemLabel: (item) => item,
            onChanged: (value) => setState(() => _selectedCollection = value),
          ),

          SizedBox(height: 28.h),
          AppSectionHeader(title: 'showcase.section_selection'),
          SizedBox(height: 16.h),
          AppToggleSelectionWidget(
            margin: EdgeInsets.zero,
            initialIndex: _toggleIndex,
            first: ToggleItem(
              label: 'showcase.toggle_tasks'.tr(),
              icon: Icon(Icons.check_circle_outline, size: 16.sp),
            ),
            second: ToggleItem(
              label: 'showcase.toggle_motivation'.tr(),
              icon: Icon(Icons.favorite_outline, size: 16.sp),
            ),
            onChanged: (index) => setState(() => _toggleIndex = index),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final label in _collections)
                InterestChip(
                  label: label,
                  isSelected: _selectedChips.contains(label),
                  onTap: () {
                    setState(() {
                      if (_selectedChips.contains(label)) {
                        _selectedChips.remove(label);
                      } else {
                        _selectedChips.add(label);
                      }
                    });
                  },
                ),
            ],
          ),
          SizedBox(height: 12.h),
          FilterSelectWidget(
            title: 'showcase.filter_habits'.tr(),
            isActive: _habitFilter,
            onTap: () => setState(() => _habitFilter = !_habitFilter),
          ),

          SizedBox(height: 28.h),
          AppSectionHeader(title: 'showcase.section_actions'),
          SizedBox(height: 16.h),
          Row(
            children: [
              RoundedIconButton(
                backgroundColor: colorScheme.primary,
                icon: Icon(
                  Icons.add,
                  color: colorScheme.onPrimary,
                  size: 20.sp,
                ),
                onTap: () {},
              ),
              SizedBox(width: 12.w),
              const LoadingWidget(),
              const Spacer(),
              AppButton(
                label: 'showcase.open_dialog'.tr(),
                variant: AppButtonVariant.primary,
                isExpanded: false,
                onPressed: () => ConfirmActionDialog.show(
                  context,
                  titleKey: 'showcase.dialog_title',
                  messageKey: 'showcase.dialog_message',
                  cancelLabelKey: 'common.cancel',
                  confirmLabelKey: 'common.confirm',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          AppLinkRichText(
            leadingText: 'showcase.link_leading'.tr(),
            linkText: 'showcase.link_action'.tr(),
            onLinkTap: () {},
          ),

          SizedBox(height: 28.h),
          AppSectionHeader(title: 'showcase.section_layout'),
          SizedBox(height: 16.h),
          GlassContainer(
            padding: EdgeInsets.all(16.w),
            child: Text(
              'showcase.glass_sample'.tr(),
              style: theme.textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 16.h),
          EmptyWidget(
            icon: Icons.flag_outlined,
            title: 'showcase.empty_title'.tr(),
            description: 'showcase.empty_description'.tr(),
            action: AppButton(
              label: 'showcase.empty_action'.tr(),
              onPressed: () {},
            ),
          ),
          SizedBox(height: 16.h),
          Center(
            child: PaginationWidget(
              totalPages: 12,
              currentPage: _page,
              onPageChanged: (page) => setState(() => _page = page),
            ),
          ),
        ],
      ),
    );
  }
}
