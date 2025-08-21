import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ofwhich_v2/presentation/chat/core/title_case.dart';

import '../../../../domain/user_service/model/user_object.dart';
// import 'package:ofwhich_v2/domain/user_service/model/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final imageUrl = user.photo ?? user.pictures?[0].file_url;
    final location = user.address?.address ?? "Unknown";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.75,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background Image
              SizedBox(
                width: 0.9.sw,
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: CachedNetworkImage(
                  imageUrl: imageUrl ?? "https://picsum.photos/id/237/200/300",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error, color: Colors.red, size: 40),
                  ),
                ),
              ),

              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + Online indicator
                    Row(
                      children: [
                        Text(
                          user.full_name ?? user.username ?? 'Unknown',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.circle, color: Colors.green, size: 10),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Tags (interests or attributes)
                    Wrap(
                      // spacing: 8,
                      children: [
                        if (user.relationship_status != null)
                          _tag(user.relationship_status!),
                        if (user.drinks != null) _tag("Drinks: ${user.drinks}"),
                        if (user.smokes != null) _tag("Smokes: ${user.smokes}"),
                        ...?user.interests?.map(_tag),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 70,
                            width: 200,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.grey),
                                backgroundColor: Colors.black.withOpacity(0.3),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Not Interested",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 70, // set your desired height
                            width: 200, // set your desired width
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // <-- removes rounded corners
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "I'll go for a drink",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              // Location top-right
              Positioned(
                top: 16,
                right: 16,
                child: Row(
                  children: [
                    const Text("📍", style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        height: 40.73.h,
        width: 124.w,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.transparent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text.toTitleCase(),
          style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
