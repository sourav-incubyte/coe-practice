import 'package:flutter/material.dart';

class ScrollScreen extends StatelessWidget {
  const ScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 50,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: SizedBox(
            height: 100,
            child: Semantics(
              label: 'Item ${index + 1}',
              child: ListTile(
                title: Text('Item ${index + 1}'),
                subtitle: Text('This is item number ${index + 1}'),
                leading: CircleAvatar(child: Text('${index + 1}')),
              ),
            ),
          ),
        );
      },
    );
  }
}
