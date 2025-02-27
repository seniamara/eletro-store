import 'package:flutter/material.dart';

class CustomerSupportScreen extends StatefulWidget {
  @override
  _CustomerSupportScreenState createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! How can I assist you today?', 'isBot': true, 'time': DateTime.now()},
  ];
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({'text': _messageController.text, 'isBot': false, 'time': DateTime.now()});
        _messageController.clear();
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _messages.add({'text': 'Got it! How can I help you further?', 'isBot': true, 'time': DateTime.now()});
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Support', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF00695C),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                final message = _messages[i];
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(bottom: 8), // Should be 'bottom'
                  child: Row(
                    mainAxisAlignment: message['isBot'] ? MainAxisAlignment.start : MainAxisAlignment.end,
                    children: [
                      if (message['isBot'])
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.teal[100],
                          child: Icon(Icons.support_agent, size: 20, color: Colors.teal[800]),
                        ),
                      SizedBox(width: message['isBot'] ? 8 : 0),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: message['isBot'] ? Colors.teal[50] : Colors.teal[700],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
                          ),
                          child: Text(
                            message['text'],
                            style: TextStyle(
                              color: message['isBot'] ? Colors.teal[900] : Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      if (!message['isBot']) SizedBox(width: 8),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.teal[700], size: 30),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}