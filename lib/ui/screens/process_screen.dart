import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webspark_test_project/ui/screens/result_list_screen.dart';
import 'package:webspark_test_project/utilities/search_algorithm.dart';
import 'package:webspark_test_project/ui/widgets/blue_text_button.dart';
import 'package:webspark_test_project/services/network_helper.dart';
import 'package:webspark_test_project/view_models/field_list_view_model.dart';
import 'package:webspark_test_project/models/field.dart';

class ProcessScreen extends StatefulWidget {
  final String url;

  const ProcessScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  List<Field> fields = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) async {
      fields = await NetworkHelper.getAllFields(widget.url);

      if (mounted) {
        final vm = Provider.of<SearchAlgorithm>(context, listen: false);
        for (final field in fields) {
          vm.aStarSearch(field, fields.length);
        }
      }
    });
  }

  void changeLoadingStatus() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  context.watch<SearchAlgorithm>().progress == 100
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'All calculations have been finished, you can send your result to server',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17.0),
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    '${context.watch<SearchAlgorithm>().progress.toStringAsFixed(0)}%',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child:
                          _isLoading ? const CircularProgressIndicator() : null,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Provider.of<SearchAlgorithm>(context).progress == 100
                ? BlueTextButton(
                    text: 'Send result to server',
                    onPressed: () async {
                      changeLoadingStatus();
                      await NetworkHelper.sendAllSolutions(fields);
                      changeLoadingStatus();
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultListScreen(
                              fieldListViewModel:
                                  FieldListViewModel.fromFieldsList(fields),
                            ),
                          ),
                        );
                      }
                    },
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
