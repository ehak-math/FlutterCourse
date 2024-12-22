import 'package:flutter/material.dart';

class EmptyWatchlistText extends StatelessWidget {
  const EmptyWatchlistText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Watchlist is empty',
          style: textTheme.titleMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            'After adding movies to watchlist, they will appear here.',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
