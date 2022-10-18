import 'package:flutter/material.dart';
import 'package:webspark_test_project/ui/screens/process_screen.dart';
import 'package:webspark_test_project/ui/widgets/blue_text_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _urlTextController = TextEditingController();
  final _urlFormFieldKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    _urlTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text('Set valid API base URL in order to continue'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.compare_arrows_outlined),
                        ),
                        key: _urlFormFieldKey,
                        controller: _urlTextController,
                        validator: (value) {
                          const uri =
                              'https://flutter.webspark.dev/flutter/api';
                          if (value != uri) {
                            return 'Wrong URL.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: BlueTextButton(
              text: 'Start counting process',
              onPressed: () async {
                if (_urlFormFieldKey.currentState!.validate()) {
                  //TODO my fields were here
                  final url = _urlTextController.text;

                  if (mounted) {
                    //TODO move for loop here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProcessScreen(url: url),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
