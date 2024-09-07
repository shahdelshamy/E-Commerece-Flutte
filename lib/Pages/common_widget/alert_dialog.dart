import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
  final String errorMessage;

  const ShowAlertDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35.0, bottom: 16.0, left: 16.0, right: 16.0),

            child: Container(
              alignment: Alignment.center,
              height: 180,
              child: Column(
                children: [
                  const Text(
                    'Failed To Register',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    errorMessage ?? 'No error message available',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK',style: TextStyle(fontSize: 17),),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red, backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -19,
            right: 125,
            child: CircleAvatar(
              radius: 23,
              backgroundColor: Colors.red,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 25),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

