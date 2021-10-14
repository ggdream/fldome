import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

// 我只是为了看起来明显才123.。。。
  final List<Model> _data = [
    Model(
      avatar: 'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/375.jpg',
      text: '1',
      isMyself: false, // bool默认值也是false，可以不用填，但对代码来说，有规律是好的
    ),
    Model(
      avatar: 'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/375.jpg',
      text: '2',
      isMyself: false, // bool默认值也是false，可以不用填，但对代码来说，有规律是好的
    ),
    Model(
      avatar: 'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/375.jpg',
      text: '3',
      isMyself: false, // bool默认值也是false，可以不用填，但对代码来说，有规律是好的
    ),
    Model(
      avatar: 'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/56.jpg',
      text: 'a',
      isMyself: true, // bool默认值也是false，可以不用填，但对代码来说，有规律是好的
    ),
    Model(
      avatar: 'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/375.jpg',
      text: '4',
      isMyself: false, // bool默认值也是false，可以不用填，但对代码来说，有规律是好的
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const _AppBar(),
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 点击其他地方的时候，让输入框失去焦点
        Focus.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Column(
          children: [
            // 上半部分：聊天内容显示
            chatView(),
            // 下半部分：输入框
            inputView(),
          ],
        ),
      ),
    );
  }

  /// 聊天内容显示
  Widget chatView() {
    return Expanded(
      // 到了最后，再改成ListView.builder，现在代码少点，UI逻辑会更清楚
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          itemCount: _data.length,
          itemBuilder: (context, index) {
            final model = _data.elementAt(index);
            return BubbleWidget(
              avatar: model.avatar,
              text: model.text,
              direction: model.isMyself
                  ? TextDirection.rtl
                  : TextDirection.ltr, // 那么这个时候默认值就没意义了
            );
          }),
    );
  }

  /// 最下方的输入框部分
  Widget inputView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 左侧文字输入框
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              cursorColor: Colors.black,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 右侧发送文字的按钮
          ElevatedButton(
            onPressed: _onSend,
            child: const Text('发送'),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(16),
  );

  Future<void> _onSend() async {
    final text = _controller.text;
    // 现在我们需要变成builder，把数据抽出来
    // TODO: 这里要发送到后端，是个Future，异步
    final model = Model(
      // 头像去本地存储：比如share_pref，get_storage等去拿直链
      // 这里我就写死
      avatar: 'https://cdn.jsdelivr.net/gh/mocaraka/assets/temp/56.jpg',
      text: text,
      isMyself: true,
    );

    setState(() {
      _data.add(model);
    });

    _controller.clear();
  }
}

/// 聊天气泡
class BubbleWidget extends StatelessWidget {
  const BubbleWidget({
    Key? key,
    required this.avatar,
    required this.text,
    required this.direction,
  }) : super(key: key);

  final String avatar;
  final String text;

  /// 文字方向：ltr: left to right，也就是别人说的话
  /// rtl：你自己发出的消息
  final TextDirection direction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        // 忘了用这个变量了，好了，剩下的就是再调调UI了....
        textDirection: direction,
        children: [
          CircleAvatar(
            radius: 24, // 只要不比48的二分之一小就是圆形
            backgroundImage: NetworkImage(avatar),
            child: const SizedBox(
              width: 48,
              height: 48,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(32),
              ),
              child: SelectableText(text),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.black,
      leading: const BackButton(),
      title: const Text('魔咔啦咔'),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class Model {
  final String avatar;
  final String text;
  final bool isMyself;

  Model({
    required this.avatar,
    required this.text,
    required this.isMyself,
  });
}
