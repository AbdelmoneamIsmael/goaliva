import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsPlaceholderPage extends StatelessWidget {
  const SettingsPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'placeholders.settings_title'.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
