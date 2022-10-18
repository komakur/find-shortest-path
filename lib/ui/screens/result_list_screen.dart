import 'package:flutter/material.dart';
import 'package:webspark_test_project/ui/widgets/field_list.dart';
import 'package:webspark_test_project/view_models/field_list_view_model.dart';

class ResultListScreen extends StatelessWidget {
  final FieldListViewModel fieldListViewModel;
  const ResultListScreen({Key? key, required this.fieldListViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FieldList(fieldListViewModel: fieldListViewModel),
    );
  }
}
