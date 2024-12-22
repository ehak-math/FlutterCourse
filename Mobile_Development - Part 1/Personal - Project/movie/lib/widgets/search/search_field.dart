import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final ValueChanged<String> onChanged; // Callback to pass search input

  const SearchField({
    super.key,
    required this.onChanged,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Form(
      child: TextFormField(
        controller: _textController,
        cursorColor: const Color(0xffa9aaac),
        cursorWidth: 1,
        style: textTheme.bodyLarge,
        onChanged: widget.onChanged, // Trigger the callback
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffef233c),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffef233c),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xffa9aaac),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              _textController.clear();
              widget.onChanged(''); // Clear the search query
            },
            child: const Icon(
              Icons.clear_rounded,
              color: Color(0xffa9aaac),
            ),
          ),
          hintText: 'Search',
          hintStyle: textTheme.bodyLarge,
        ),
      ),
    );
  }
}
