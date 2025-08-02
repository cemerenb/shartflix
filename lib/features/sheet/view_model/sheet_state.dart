import 'package:flutter/widgets.dart';

abstract class SheetState {}

class SheetHidden extends SheetState {}

class SheetVisible extends SheetState {
  final Widget sheet;

  SheetVisible(this.sheet);
}
