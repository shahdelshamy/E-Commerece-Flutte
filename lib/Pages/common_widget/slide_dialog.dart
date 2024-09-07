import 'package:flutter/material.dart';

class SlideDialog extends StatefulWidget {
  final String message;
  final bool isSuccess;
  final AnimationController controller;

  const SlideDialog({
    Key? key,
    required this.message,
    required this.isSuccess,
    required this.controller,
  }) : super(key: key);

  @override
  _SlideDialogState createState() => _SlideDialogState();
}

class _SlideDialogState extends State<SlideDialog> {
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Curves.easeInOut,
    ));

    widget.controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: AlertDialog(
        backgroundColor: widget.isSuccess ? Colors.green : Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Row(
          children: [
            Icon(
              widget.isSuccess ? Icons.check_circle : Icons.error,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.message,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.controller.reverse().then((_) => Navigator.of(context).pop());
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
