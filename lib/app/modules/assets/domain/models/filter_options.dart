import 'button_filter_type.dart';

class FilterOptions {
  final String? name;
  final ButtonFilterType? buttonFilterType;

  FilterOptions({this.name, this.buttonFilterType});

  bool get hasNoFilter {
    return !hasName && !hasSensorSelected && !hasCriticalSelected;
  }

  bool get hasName {
    return name != null && name!.isNotEmpty;
  }

  bool get hasSensorSelected {
    return buttonFilterType != null &&
        buttonFilterType == ButtonFilterType.sensor;
  }

  bool get hasCriticalSelected {
    return buttonFilterType != null &&
        buttonFilterType == ButtonFilterType.critical;
  }
}