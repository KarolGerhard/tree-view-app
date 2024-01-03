import 'package:flutter/material.dart';

import '../../domain/models/button_filter_type.dart';

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
            padding: const EdgeInsets.all(12),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD8DFE6),
              ),
              borderRadius: BorderRadius.circular(8),
              color: currentValue == ButtonFilterType.sensor
                  ? Colors.blueAccent
                  : Colors.white,
            ),
            child: const Row(
              children: [
                Icon(Icons.bolt, color: Color(0xFF8e98a3)),
                Text(
                  "Sensor de Energia",
                  style: TextStyle(
                    color: Color(0xFF77818C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => _onChanged(ButtonFilterType.critical),
          child: Container(
            padding: const EdgeInsets.all(12),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD8DFE6),
              ),
              borderRadius: BorderRadius.circular(8),
              color: currentValue == ButtonFilterType.critical
                  ? Colors.blueAccent
                  : Colors.white,
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(0xFF8e98a3),
                ),
                Text(
                  "Crítico",
                  style: TextStyle(
                    color: Color(0xFF77818C),
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
