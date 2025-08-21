// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/font.dart';
import '../../profile/model/circle_model.dart';

class MultiSelectChip extends StatefulWidget {
  final List<CircleModel>? interests;
  // final Function(List<CircleModel>)? onSelectionChanged;
  // final Function(List<CircleModel>)? onMaxSelected;
  // final int? maxSelection;

  const MultiSelectChip({super.key, this.interests});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<CircleModel> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.interests?.forEach((item) {
      choices.add(GestureDetector(
        onTap: () {
          // toggleSelection(item);
          // log(selectedChoices.toString());
        },
        child: Container(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEC5873).withOpacity(0.1),
              border: Border.all(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  selectImageForInterest(
                    interest: item.title ?? "",
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    item.title ?? '',
                    style: TextStyle(
                        fontFamily: Font.rubik,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFEC5873)),
                  ),
                ],
              ),
            ),
          ),

          
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }

  Widget selectImageForInterest({required String interest}) {
    switch (interest) {
      case "Cars":
        return Image.asset("assets/images/pngs/car.png");

      case "Swimming":
        return Image.asset("assets/images/pngs/swimming.png");
      case "Gaming":
        return Image.asset("assets/images/pngs/gaming.png");

      case "Yoga":
        return Image.asset("assets/images/pngs/yoga.png");
      case "Food & Drinks":
        return Image.asset("assets/images/pngs/food.png");
      case "Health":
        return Image.asset("assets/images/pngs/health.png");
      case "Travel":
        return Image.asset("assets/images/pngs/travel.png");
      case "Community":
        return Image.asset("assets/images/pngs/community.png");
      case "Business":
        return Image.asset("assets/images/pngs/business.png");
      case "Road Trip":
        return Image.asset("assets/images/pngs/road_trip.png");
      case "Sport":
        return Image.asset("assets/images/pngs/sport.png");
      case "Gym":
        return Image.asset("assets/images/pngs/gym.png");
      case "Cycling":
        return Image.asset("assets/images/pngs/cycling.png");
      case "Healthy Eating":
        return Image.asset("assets/images/pngs/eating.png");
      default:
        return Image.asset("assets/images/pngs/eating.png");
    }
  }
}
