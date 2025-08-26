import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';

@RoutePage()
class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: OfWhichAppBar(
        titleText: 'Personal Information',
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
