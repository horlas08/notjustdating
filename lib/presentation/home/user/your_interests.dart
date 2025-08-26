// import 'package:flutter/foundation.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/core/font.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_appbar.dart';
import 'package:ofwhich_v2/presentation/home/user/widgets/app_image_widget.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:provider/provider.dart';

import '../../../application/home_view_model/home_view_model.dart';
import '../../../domain/user_service/model/user_object.dart';
import '../../routes/app_router.dart';
import 'constants/swipe_enum.dart';

@RoutePage()
class YourInterests extends StatefulWidget {
  const YourInterests({super.key});

  @override
  State<YourInterests> createState() => _YourInterestsState();
}

class _YourInterestsState extends State<YourInterests> {
  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<HomeViewModel>().getProfileLikes();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      // viewModelBuilder: () => getIt<HomeViewModel>(),
      // onViewModelReady: (h) {
      //   h.getProfileLikes();
      // },
      builder: (context, model, child) => Scaffold(
          appBar: const OfWhichAppBar(
            titleText: "Your Likes",
            leadingIcon: true,
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: model.isBusy
                ? const Center(child: CircularProgressIndicator())
                : model.profileLikes.isEmpty
                    ? const Center(child: Text('No profile likes yet'))
                    : Column(
                        children: [
                          Text(
                            'Likes ${model.profileLikes.length}',
                            style: TextStyle(
                              fontFamily: Font.inter,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              itemCount: model.profileLikes.length,
                              padding: EdgeInsets.all(10.w),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // Number of columns
                                      crossAxisSpacing: 10.0.w,
                                      mainAxisSpacing: 8.0.w,
                                      childAspectRatio: 0.75),
                              itemBuilder: (context, index) {
                                UserModel profileLikes =
                                    model.profileLikes[index];
                                return InkResponse(
                                    onTap: () {
                                      getIt<AppRouter>().push(
                                          SelectedProfileRoute(
                                              profile: profileLikes,
                                              currentIndex: 0,
                                              swipeNotifier: swipeNotifier,
                                              viewModel: getIt<HomeViewModel>(),
                                              selectedProfileCallBack: () {}));
                                    },
                                    child: InterestCard(
                                        profileLikes: profileLikes));
                              })
                        ],
                      ),
          ))),
    );
  }
}

class InterestCard extends StatelessWidget {
  const InterestCard({
    super.key,
    required this.profileLikes,
  });

  final UserModel profileLikes;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Stack(
          children: [
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: AppImageWidget(imageUrl: profileLikes.photo ?? ""),
              ),
            ),
            Positioned(
              bottom: 30.h,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profileLikes.full_name ?? "",
                      style: TextStyle(
                          fontFamily: Font.inter,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    Text(
                      profileLikes.gender ?? "",
                      style: TextStyle(
                        fontFamily: Font.inter,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
