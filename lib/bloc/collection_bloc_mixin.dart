import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CollectionBlocMixin<BlocEvent, BlocState>
    extends Bloc<BlocEvent, BlocState> {
  CollectionBlocMixin(BlocState initialState) : super(initialState);

  void loadMore();
}
