import 'package:flutter/material.dart';
import './setting_section.dart';
import '../../colors.dart';

class SettingList extends StatelessWidget {
  final List<SettingsSection> sections;
  final Color backgroundColor;

  const SettingList({
    Key key,
    this.sections,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.light
          ? backgroundGray
          : backgroundColor ?? Colors.black,
      child: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          SettingsSection current = sections[index];
          SettingsSection futureOne;
          try {
            futureOne = sections[index + 1];
          } catch (e) {}

          // Add divider if title is null
          if (futureOne != null && futureOne.title != null) {
            current.showBottomDivider = false;
            return current;
          } else {
            current.showBottomDivider = true;
            return current;
          }
        },
      ),
    );
  }
}