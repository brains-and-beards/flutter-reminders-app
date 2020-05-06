import 'package:flutter/material.dart';

enum DisplayType {
  mobile,
  tablet,
  desktop,
}

const _tabletBreakpoint = 600;
const _desktopBreakpoint = 950;

DisplayType displayTypeOf(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  double deviceWidth = 0;

  if (orientation == Orientation.landscape) {
    deviceWidth = width;
  } else {
    deviceWidth = height;
  }

  if (deviceWidth > _desktopBreakpoint) {
    return DisplayType.desktop;
  }
  if (deviceWidth > _tabletBreakpoint) {
    return DisplayType.tablet;
  } else {
    return DisplayType.mobile;
  }
}

bool isDesktop(BuildContext context) {
  return displayTypeOf(context) == DisplayType.desktop;
}

bool isMobile(BuildContext context) {
  return displayTypeOf(context) == DisplayType.desktop;
}

bool isTablet(BuildContext context) {
  return displayTypeOf(context) == DisplayType.desktop;
}

bool isLanscapeNotchDevice(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  final padding = MediaQuery.of(context).viewPadding;

  if (orientation == Orientation.landscape) {
    return padding.right > 0 || padding.left > 0;
  } else {
    return false;
  }
}
