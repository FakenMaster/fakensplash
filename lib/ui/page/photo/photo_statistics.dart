import 'package:fakensplash/bloc/photo_statistics/photo_statistics_bloc.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:fakensplash/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

class PhotoStatisticsPage extends StatelessWidget {
  final String id;
  PhotoStatisticsPage({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoStatisticsBloc, PhotoStatisticsState>(
      builder: (context, state) {
        if (state is PhotoStatisticsSuccess) {
          var statistics = state.statistics;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Tuple2<IconData, String>>[
                Tuple2(Icons.file_download,
                    '${statistics?.downloads?.total ?? 0} Downloads'),
                Tuple2(
                    Icons.favorite, '${statistics?.likes?.total ?? 0} Likes'),
                Tuple2(
                    Icons.visibility, '${statistics?.views?.total ?? 0} Views'),
              ].map((e) {
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(e.item1),
                        SizedBox(
                          width: 20,
                        ),
                        Text(e.item2),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        } else {
          if (state is PhotoStatisticsError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              toast('load photo statistics fail');
            });
            print('${state.error}');
          } else if (state is PhotoStatisticsInitial) {
            context
                .bloc<PhotoStatisticsBloc>()
                .add(PhotoStatisticsEvent.loadData(id));
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
      },
    );
  }
}
