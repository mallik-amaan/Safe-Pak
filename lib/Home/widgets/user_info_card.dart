import 'package:flutter/material.dart';

Widget UserInfoCard(BuildContext context){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Hello User",
              style: Theme.of(context).textTheme.headlineLarge,),
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  Text("location, Country"),
                ],
              )
            ],
          ),
        ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/icon/boy.png",height: 100,width: 100,),
      )
      ],
    ),
  );
}