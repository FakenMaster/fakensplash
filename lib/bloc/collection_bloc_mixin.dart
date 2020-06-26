import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CollectionBlocMixin<BlocEvent, BlocState>
    extends Bloc<BlocEvent, BlocState> {
  void loadMore();
}
