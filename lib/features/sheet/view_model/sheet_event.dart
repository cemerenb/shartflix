import 'package:flutter/widgets.dart';

abstract class SheetEvent {}

class ShowSheetEvent extends SheetEvent {
  final Widget sheet;

  ShowSheetEvent(this.sheet);
}

class HideSheetEvent extends SheetEvent {}
