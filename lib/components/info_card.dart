import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class InfoCard extends StatelessWidget {
  final String name;
  final String profession;
  const InfoCard({
    super.key,
    required this.name,
    required this.profession,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white,),
      ),
      subtitle: Text(
        profession,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
