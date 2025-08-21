// ignore_for_file: library_private_types_in_public_api

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../general_widgets/custom_appbar.dart';

@RoutePage()
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool likes = true;
  bool comments = true;
  bool newFollowers = true;
  bool mentionsAndTags = true;
  bool profileViews = true;
  bool reports = true;
  bool directMessages = true;
  bool directMessagesPreviews = true;
  bool postFromPeopleYouKnow = true;
  bool repostFromOthers = true;
  bool postYouMightLike = true;
  bool peopleYouMayKnow = true;
  bool customizedUpdateAndMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OfWhichAppBar(
        titleText: "Notification Settings",
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('In-app notification'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            title: const Text('Push notification schedule'),
            subtitle:
                const Text('Set a schedule to turn off push notification'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle tap
            },
          ),
          const Divider(),
          _buildSectionHeader('Interaction'),
          _buildSwitchListTile('Likes', likes, (value) {
            setState(() {
              likes = value;
            });
          }),
          _buildSwitchListTile('Comments', comments, (value) {
            setState(() {
              comments = value;
            });
          }),
          _buildSwitchListTile('New followers', newFollowers, (value) {
            setState(() {
              newFollowers = value;
            });
          }),
          _buildSwitchListTile('Mentions and Tags', mentionsAndTags, (value) {
            setState(() {
              mentionsAndTags = value;
            });
          }),
          _buildSwitchListTile('Profile views', profileViews, (value) {
            setState(() {
              profileViews = value;
            });
          }),
          _buildSwitchListTile('Reports', reports, (value) {
            setState(() {
              reports = value;
            });
          }),
          const Divider(),
          _buildSectionHeader('Messages'),
          _buildSwitchListTile('Direct messages', directMessages, (value) {
            setState(() {
              directMessages = value;
            });
          }),
          _buildSwitchListTile(
              'Direct messages previews', directMessagesPreviews, (value) {
            setState(() {
              directMessagesPreviews = value;
            });
          }),
          const Divider(),
          _buildSectionHeader('Personalized post suggestions'),
          _buildSwitchListTile(
              'Post from people you know', postFromPeopleYouKnow, (value) {
            setState(() {
              postFromPeopleYouKnow = value;
            });
          }),
          _buildSwitchListTile('Repost from others', repostFromOthers, (value) {
            setState(() {
              repostFromOthers = value;
            });
          }),
          _buildSwitchListTile('Post you might like', postYouMightLike,
              (value) {
            setState(() {
              postYouMightLike = value;
            });
          }),
          const Divider(),
          _buildSectionHeader('Other'),
          _buildSwitchListTile('People you may know', peopleYouMayKnow,
              (value) {
            setState(() {
              peopleYouMayKnow = value;
            });
          }),
          _buildSwitchListTile(
              'Customized update and more', customizedUpdateAndMore, (value) {
            setState(() {
              customizedUpdateAndMore = value;
            });
          }),
          ListTile(
            title: const Text('Email notification'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle tap
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchListTile(
      String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.red,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
