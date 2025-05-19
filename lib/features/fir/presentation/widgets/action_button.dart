import 'package:flutter/material.dart';

Widget actionButton(BuildContext context, String actionTitle, Function action) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).primaryColor,
    ),
    child: TextButton(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          actionTitle,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
      onPressed: () => action,
    ),
  );
}
