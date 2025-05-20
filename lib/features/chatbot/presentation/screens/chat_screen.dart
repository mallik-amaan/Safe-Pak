import 'package:flutter/material.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/core/services/ai_chatbot_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final GeminiService _geminiService = GeminiService();

  List<_ChatMessage> _messages = [];
  bool _isThinking = false;

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _isThinking = true;
      _controller.clear();
    });

    _scrollToBottom();

    try {
      final response = await _geminiService.generateContent(text);
      setState(() {
        _messages.add(_ChatMessage(text: response, isUser: false));
        _isThinking = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages
            .add(_ChatMessage(text: "Error: ${e.toString()}", isUser: false));
        _isThinking = false;
      });
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 80,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildMessageBubble(_ChatMessage message) {
    final isUser = message.isUser;
    final alignment =
        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = isUser ? Theme.of(context).primaryColor : AppColors.lightGrey;
    final textColor = !isUser ? Theme.of(context).primaryColor : Colors.white;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          padding: EdgeInsets.all(12),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(message.text, style: TextStyle(color: textColor)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = List<Widget>.from(_messages.map(_buildMessageBubble));
    if (_isThinking) {
      messages.add(_buildMessageBubble(
          _ChatMessage(text: "Thinking...", isUser: false)));
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            "SafePak AI",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 10),
              children: messages,
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: "Ask a legal question...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                IconButton(
                  icon:
                      Icon(Icons.send, color: Theme.of(context).highlightColor),
                  onPressed: _sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  _ChatMessage({required this.text, required this.isUser});
}
