import 'package:flutter/material.dart';
import '../constants.dart';

class GradientScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool extendBehindAppBar;

  const GradientScaffold({
    required this.title,
    required this.body,
    this.extendBehindAppBar = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          title,
          style: kapptitle,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey,Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: body,
      ),
    );
  }
}
