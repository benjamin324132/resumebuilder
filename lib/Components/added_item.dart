import 'package:flutter/material.dart';

import '../Utils/constants.dart';

class AddedItem extends StatelessWidget {
  const AddedItem({
    Key? key,
    required this.title,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);
  final String title;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(defaultPadding),
        margin: const EdgeInsets.only(bottom: defaultPadding / 3),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius:
                BorderRadius.circular(defaultPadding / 2)),
        child: Row(
          children: [
            Expanded(
                child: Text(
              "$title",
              maxLines: 1,
            )),
            GestureDetector(
                onTap: onEdit, child: const Icon(Icons.edit)),
            const SizedBox(
              width: defaultPadding / 2,
            ),
            GestureDetector(
                onTap: onDelete, child: const Icon(Icons.delete)),
          ],
        ));
  }
}