import 'package:flutter/material.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/usecases/list_data.dart';

extension ItemExtensions on Item {
  String get icon {
    if (this is Component) return "assets/icons/components_icon.png";
    if (this is Local) return "assets/icons/location_icon.png";
    if (this is Asset) return "assets/icons/assets_icon.png";
    return "assets/icons/components_icon.png";
  }

  Icon? get sensorIcon {
    if (this is! Asset) return null;

    return SensorIconBuilder()
        // .setSensorType((this as Asset).sensorType)
        .setStatus((this as Asset).status)
        .build();
  }
}

class SensorIconBuilder {
  Color? color;
  IconData? icon;
  String? status;

  // ignore: constant_identifier_names
  static const OPERATING = 'operating';

  SensorIconBuilder();

  // setSensorType(String? sensorType) {
  //   if (sensorType == null) return this;
  //   if (status == 'energy') {
  //     icon = Icons.bolt;
  //   } else {
  //     icon = Icons.circle;
  //   }
  //   return this;
  // }

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
