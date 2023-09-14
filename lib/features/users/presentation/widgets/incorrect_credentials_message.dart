import 'package:flutter/material.dart';
import 'package:list_of_transactions/app/theme.dart';

class IncorrectCredentialsMessage extends StatelessWidget {
  const IncorrectCredentialsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(spaceSm),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error.withOpacity(opacity),
          border: Border.all(color: Theme.of(context).colorScheme.error),
          borderRadius: borderRadius),
      child: const Text(
        'Incorrect email or password.',
        style: TextStyle(),
      ),
    );
  }
}
