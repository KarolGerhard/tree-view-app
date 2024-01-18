import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/button_filter_type.dart';
import '../../domain/models/filter_options.dart';
import 'select_filter.dart';

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
  final searchController = TextEditingController();
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
              controller: searchController,
              cursorColor: Colors.grey,
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(color: Color(0xFF8e98a3))),
              onChanged: _onChanged,
              // initialValue: currentValue,
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
                suffix: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(
                    
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFF8e98a3),
                      size: 24,
                    ),
                    onPressed: () {
                      searchController.clear();
                      _onChanged('');
                    },
                  ),
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
