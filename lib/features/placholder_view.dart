import 'package:flutter/material.dart';

class PlacholderView extends StatefulWidget {
  const PlacholderView({super.key});

  @override
  State<PlacholderView> createState() => _PlacholderViewState();
}

class _PlacholderViewState extends State<PlacholderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Placeholder View')),
      body: const Placeholder(),
    );
  }
}
