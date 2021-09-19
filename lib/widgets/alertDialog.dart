import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants.dart';

class AlertWidget extends StatelessWidget {
  final String? text;
  const AlertWidget({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: 20.0, vertical: MediaQuery.of(context).size.height / 3),
        content: Center(
          child: Text(
            "\nPlease fill the required fields",
          ),
        ),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kMyBlue),
              ),
              onPressed: () {
                return Navigator.pop(context);
              },
              child: Text(
                "Click to go back",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height / 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
