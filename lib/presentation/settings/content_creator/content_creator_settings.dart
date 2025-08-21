import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';

import '../../../application/profile/profile_view_model.dart';
import '../../routes/app_router.dart';

@RoutePage()
class ContentCreatorSettings extends StatelessWidget {
  const ContentCreatorSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OfWhichAppBar(
        titleText: "Settings",
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Personal information'),
            onTap: () {
              getIt<AppRouter>().push(const PersonalSettings());
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notification settings'),
            onTap: () {
              getIt<AppRouter>().push(const NotificationSettingsRoute());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => NotificationSettingsScreen()),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Security settings'),
            onTap: () {
              getIt<AppRouter>().push(const SecuritySettingsRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.password_outlined),
            title: const Text('Password Manager'),
            onTap: () {
              getIt<AppRouter>().push(const PasswordManager());

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PasswordManagerScreen()),
              // );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              // getIt<ProfileViewModel>().logOut();
              getIt<AppRouter>()
                  .pushAndPopUntil(LoginRoute(), predicate: (val) => false);
              // Log out the user
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Delete Account'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => DeleteAccountScreen()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
