import 'package:flutter/material.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFFEAEFF3),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: TextField(
            // controller: controller.searchController,
            cursorColor: Colors.grey,
            style: const TextStyle(color: Color(0xFF8e98a3)),
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
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  // controller.buscar('');
                },
              ),
            ),
            // onChanged: (value) => controller.buscar(value),
          ),
        ));
  }
}
