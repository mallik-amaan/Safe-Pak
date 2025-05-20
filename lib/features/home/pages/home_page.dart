import 'package:go_router/go_router.dart';
import 'package:safepak/features/home/widgets/home_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'AI Chat',
        elevation: 4.0,
        focusColor: Colors.white,
        backgroundColor: Theme.of(context).highlightColor,
        onPressed: () {
          context.push('/ai-chat');
        },
        child: const Icon(
          Icons.support_agent_outlined,
          color: Colors.white,
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.85,
        children: homeCards(context),
      ),
    );
  }
}
