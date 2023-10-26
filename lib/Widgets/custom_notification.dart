import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNotification extends StatefulWidget {
  const CustomNotification({Key? key}) : super(key: key);

  @override
  State<CustomNotification> createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: customListTile(context),
            );
          },
        ),
      ],
    );
  }

  ListTile customListTile(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      tileColor: Colors.transparent,
      title: Text(
        'Ride Completed',
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Test is delivered successfully to the Lab\n15 mins ago',
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Colors.grey,
          fontSize: 10,
        ),
      ),
    );
  }
}
