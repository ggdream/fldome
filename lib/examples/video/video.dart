import 'package:dart_vlc/dart_vlc.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final Player _player = Player(id: 111);
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    final media = Media.network(
        'https://video.pearvideo.com/mp4/third/20211014/cont-1743699-10616834-113840-hd.mp4');
    _player.open(media, autoStart: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        controller: _controller,
        headerSliverBuilder: _headerSliverBuilder,
        pinnedHeaderSliverHeightBuilder: () {
          return kToolbarHeight + MediaQuery.of(context).padding.top;
        },
        body: Text('data'),
      ),
    );
  }

  List<Widget> _headerSliverBuilder(BuildContext context, bool _) {
    return [
      SliverAppBar(
        leading: BackButton(),
        pinned: true,
        expandedHeight: 240,
        flexibleSpace: FlexibleSpaceBar(
          title: InkWell(
            child: Text('点击回来'),
            onTap: () {
              _controller.animateTo(
                0,
                duration: Duration(milliseconds: 300),
                curve: Curves.bounceInOut,
              );
            },
          ),
          background: Video(
            player: _player,
          ),
        ),
      ),
    ];
  }
}
