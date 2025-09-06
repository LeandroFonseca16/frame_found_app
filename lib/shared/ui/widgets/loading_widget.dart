import 'package:flutter/material.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          if (text != null) ...[
            SizedBox(height: 16),
            Text(
              text!,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ],
      ),
    );
  }
}
