import 'package:flutter/material.dart';
import 'package:webspark_test_project/ui/widgets/field_table.dart';
import 'package:webspark_test_project/view_models/field_list_view_model.dart';

class PreviewScreen extends StatelessWidget {
  final FieldViewModel fieldViewModel;
  const PreviewScreen({Key? key, required this.fieldViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          FieldTable(field: fieldViewModel),
          Text(
            fieldViewModel.path,
            style: const TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
