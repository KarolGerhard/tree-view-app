import 'package:flutter/material.dart';
import 'package:tree_view_desafio/app/modules/assets/domain/usecases/filter_data.dart';
import 'package:tree_view_desafio/app/modules/assets/presentation/widgets/select_filter.dart';

import '../../domain/models/button_filter_type.dart';

class SearchFilter extends StatefulWidget {
  final String? initialValue;
  final void Function(FilterOptions)? onChanged;

  const SearchFilter({
    super.key,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  String currentValue = '';
  ButtonFilterType currentFilter = ButtonFilterType.none;

  @override
  void initState() {
    currentValue = widget.initialValue ?? '';
    super.initState();
  }

  void _onChanged(String value) {
    setState(() {
      currentValue = value;
    });
    widget.onChanged?.call(FilterOptions(
      name: value,
      buttonFilterType: currentFilter,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFEAEFF3),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: TextFormField(
              cursorColor: Colors.grey,
              style: const TextStyle(color: Color(0xFF8e98a3)),
              onChanged: _onChanged,
              initialValue: currentValue,
              decoration: InputDecoration(
                fillColor: const Color(0xFFEAEFF3),
                hintText: "Buscar Ativo ou Local",
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintStyle: const TextStyle(
                    color: Color(0xFF8e98a3), fontSize: 16, height: 1.2),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF8e98a3),
                  size: 24,
                ),
                suffix: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFF8e98a3),
                    size: 18,
                  ),
                  onPressed: () => setState(() => currentValue = ''),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SelectFilter(
            onChanged: (value) {
              setState(() => currentFilter = value);
              widget.onChanged?.call(
                FilterOptions(
                  name: currentValue,
                  buttonFilterType: value,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
