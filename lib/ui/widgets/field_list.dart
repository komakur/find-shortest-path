import 'package:flutter/material.dart';
import 'package:webspark_test_project/ui/screens/preview_screen.dart';
import 'package:webspark_test_project/view_models/field_list_view_model.dart';

//list of fields path
class FieldList extends StatelessWidget {
  final FieldListViewModel fieldListViewModel;
  const FieldList({Key? key, required this.fieldListViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: fieldListViewModel.fields.length,
        itemBuilder: (context, index) {
          final field = fieldListViewModel.fields[index];
          return ListTile(
            shape: const Border(
              bottom: BorderSide(),
            ),
            title: Center(
              child: Text(
                field.path,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PreviewScreen(
                          fieldViewModel: fieldListViewModel.fields[index])));
            },
          );
        });
  }
}
