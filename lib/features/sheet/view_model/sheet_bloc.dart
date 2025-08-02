import 'package:flutter_bloc/flutter_bloc.dart';
import 'sheet_event.dart';
import 'sheet_state.dart';

class SheetBloc extends Bloc<SheetEvent, SheetState> {
  SheetBloc() : super(SheetHidden()) {
    on<ShowSheetEvent>((event, emit) => emit(SheetVisible(event.sheet)));
    on<HideSheetEvent>((event, emit) => emit(SheetHidden()));
  }
}
