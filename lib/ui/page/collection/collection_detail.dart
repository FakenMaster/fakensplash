import 'package:auto_route/auto_route.dart';
import 'package:fakensplash/bloc/user_profile/user_profile_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/page/photo/collection_photo_page.dart';
import 'package:fakensplash/ui/page/user/user_profile.dart';
import 'package:fakensplash/ui/widget/persistent_title.dart';
import 'package:fakensplash/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class CollectionDetailPage extends StatefulWidget {
  final Collection collection;

  const CollectionDetailPage({Key key, this.collection}) : super(key: key);

  @override
  _CollectionDetailPageState createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('${widget.collection.title}'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.public),
                onPressed: () {
                  // Todo:这个链接好像要加上本应用的数据
                  launchUrl(widget.collection.links.html);
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share(widget.collection.links.html,
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
              )
            ],
          ),
          SliverPersistentHeader(
            delegate: PersistentTitle(
              Container(
                child: Material(
                  elevation: 1.0,
                  child: Container(
                    height: kTextTabBarHeight,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => _toUserProfile(widget.collection.user),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                  widget.collection.user.profileImage.medium,
                                ))),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'By ${widget.collection.user.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CollectionPhotoPage(
              collectionId: widget.collection.id,
            ),
          ),
        ],
      ),
    );
  }

  void _toUserProfile(User user) {
    ExtendedNavigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return MultiProvider(
          providers: [
            Provider(
              create: (_) => user,
            ),
            BlocProvider(
              create: (_) => UserProfileBloc(),
            )
          ],
          child: UserProfilePage(),
        );
      },
    ));
  }
}
