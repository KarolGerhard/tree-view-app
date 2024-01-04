import 'package:flutter/material.dart';
import '../../domain/models/asset_model.dart';
import '../../domain/models/compoments_model.dart';
import '../../domain/models/item_model.dart';
import '../../domain/models/local_model.dart';

extension ItemExtensions on Item {
  String get icon {
    if (this is Local) return "assets/icons/location_icon.png";
    if ((this is Component && (this as Component).sensorType != null) ||
        (this is Asset && (this as Asset).sensorType != null)) {
      return "assets/icons/components_icon.png";
    }
    if (this is Asset) return "assets/icons/assets_icon.png";
    return "assets/icons/components_icon.png";
  }

  Icon? get sensorIcon {
    if (this is! Asset) return null;

    return SensorIconBuilder().setStatus((this as Asset).status).build();
  }
}

class SensorIconBuilder {
  Color? color;
  IconData? icon;
  String? status;

  // ignore: constant_identifier_names
  static const OPERATING = 'operating';

  SensorIconBuilder();

  setStatus(String? status) {
    if (status == null) return this;
    if (status == 'operating') {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
    this.status = status;
    return this;
  }

  Icon? build() {
    return color != null
        ? Icon(
            status == OPERATING ? Icons.bolt_rounded : Icons.circle,
            color: color,
            size: 16,
          )
        : null;
  }
}
