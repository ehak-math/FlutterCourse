import 'package:flutter/material.dart';


class SearchText extends StatelessWidget {
  const SearchText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'search',
            style: textTheme.titleMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              'searchText',
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
