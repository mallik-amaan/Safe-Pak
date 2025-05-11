import 'package:criminal_catcher/Home/widgets/home_card.dart';
import 'package:criminal_catcher/Home/widgets/user_info_card.dart';
import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:30.0,left: 8,right: 8),
        child: Column(
        children:[
          UserInfoCard(context),
          Expanded(
            child: GridView.count(
            padding: const EdgeInsets.all(16.0),
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.85,
            children: HomeCards(context),
                    ),
          ),]),
      )
    );
  }
}