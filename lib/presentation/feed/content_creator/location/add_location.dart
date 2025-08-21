import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/application/post_view_model/content_creator/post_view_model.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:stacked/stacked.dart';

import '../../../general_widgets/custom_textfield.dart';

@RoutePage()
class LocationAdd extends StatefulWidget {
  const LocationAdd({super.key});

  @override
  State<LocationAdd> createState() => _LocationAddState();
}

class _LocationAddState extends State<LocationAdd> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
      viewModelBuilder: () => getIt<PostViewModel>(),
      onViewModelReady: (c) {
        c.getLocations();
      },
      builder: (context, model, child) => Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.72,
                      child: CustomTextFieldWidget(
                        controller: controller,
                        prefix: const Icon(Icons.search),
                        hintText: "Search location ...",
                        onTap: () {
                          model.setIsSearching(true);
                        },
                        onChanged: (h) {
                          model.search(val: h);
                        },
                      )),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      context.router.pop();
                      // getIt<AppRouter>().pop();
                    },
                    child: Text("Cancel",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: Font.rubik,
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              if (model.isSearching) ...[
                if (model.filteredLocation.isEmpty)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment.center,
                    child: Text("No results found",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontFamily: Font.rubik,
                            fontWeight: FontWeight.w500)),
                  )
                else
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.78,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 20.h,
                          );
                        },
                        itemCount: model.filteredLocation.length,
                        shrinkWrap: false,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.router.pop(model.filteredLocation[index]);
                              // getIt<AppRouter>()
                              //     .pop(model.filteredLocation[index]);
                            },
                            child: Text(model.filteredLocation[index].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontFamily: Font.rubik,
                                    fontWeight: FontWeight.w500)),
                          );
                        },
                      )),
              ] else if (model.isBusy) ...[
                Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator())
              ] else ...[
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.78,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20.h,
                        );
                      },
                      itemCount: model.locations.length,
                      shrinkWrap: false,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            log("callellllleddddd");
                            context.router.pop(model.locations[index]);

                            // getIt<AppRouter>()
                            //     .pop<LocationModel>(model.locations[index]);
                          },
                          child: Text(model.locations[index].name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontFamily: Font.rubik,
                                  fontWeight: FontWeight.w500)),
                        );
                      },
                    ))
              ]
            ],
          ),
        ),
      )),
    );
  }
}
