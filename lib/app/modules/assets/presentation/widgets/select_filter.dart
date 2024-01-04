import 'package:flutter/material.dart';
import '../../domain/models/button_filter_type.dart';
import '../utils/theme.dart';

class SelectFilter extends StatefulWidget {
  final void Function(ButtonFilterType)? onChanged;
  final ButtonFilterType? initialValue;
  const SelectFilter({super.key, this.onChanged, this.initialValue});

  @override
  State<SelectFilter> createState() => _SelectFilterState();
}

class _SelectFilterState extends State<SelectFilter> {
  ButtonFilterType currentValue = ButtonFilterType.none;
  @override
  void initState() {
    currentValue = widget.initialValue ?? ButtonFilterType.none;
    super.initState();
  }

  _onChanged(ButtonFilterType value) {
    setState(() {
      currentValue = currentValue == value ? ButtonFilterType.none : value;
    });
    widget.onChanged?.call(currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _onChanged(ButtonFilterType.sensor),
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD8DFE6),
              ),
              borderRadius: BorderRadius.circular(8),
              color: currentValue == ButtonFilterType.sensor
                  ? ThemeApp.theme.primaryColor
                  : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(
                    Icons.bolt,
                    color: currentValue == ButtonFilterType.sensor
                        ? Colors.white
                        : Color(0xFF8e98a3),
                    size: 20,
                  ),
                ),
                Text(
                  "Sensor de Energia",
                  style: TextStyle(
                    color: currentValue == ButtonFilterType.sensor
                        ? Colors.white
                        : const Color(0xFF77818C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _onChanged(ButtonFilterType.critical),
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD8DFE6),
              ),
              borderRadius: BorderRadius.circular(8),
              color: currentValue == ButtonFilterType.critical
                  ? ThemeApp.theme.primaryColor
                  : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(
                    Icons.info_outline,
                    size: 20,
                    color: currentValue == ButtonFilterType.critical
                        ? Colors.white
                        : Color(0xFF8e98a3),
                  ),
                ),
                Text(
                  "Crítico",
                  style: TextStyle(
                    color: currentValue == ButtonFilterType.critical
                        ? Colors.white
                        : const Color(0xFF77818C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
