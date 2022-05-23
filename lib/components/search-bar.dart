import "package:flutter/material.dart";

class SearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  const SearchBar({
    Key? key,
    required this.hint,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: .8 * size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0),
          border: Border.all(
              color: Colors.white,
              width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        ),
      ),
    );

  }
}
