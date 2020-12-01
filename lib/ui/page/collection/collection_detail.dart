import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/page/photo/collection_photo_page.dart';
import 'package:fakensplash/ui/page/user/user_profile.dart';
import 'package:fakensplash/ui/widget/persistent_title.dart';
import 'package:fakensplash/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
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
                    pinned: true,
                    delegate: PersistentTitle(
                      Container(
                        child: Material(
                          elevation: 1.0,
                          color: Colors.white,
                          child: Container(
                            height: kTextTabBarHeight,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () => toUserProfile(
                                  context, widget.collection.user),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                          widget.collection.user.profileImage
                                              .medium,
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
                ];
              },
              body: CollectionPhotoPage(
                collectionId: widget.collection.id,
              )),
        ));
  }
}
