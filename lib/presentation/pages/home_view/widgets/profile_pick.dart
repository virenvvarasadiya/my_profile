import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_profile/presentation/bloc/profile_bloc.dart';
import 'package:my_profile/utils/app_color.dart';
import 'package:my_profile/utils/common_spacer.dart';

class ProfilePictureView extends StatelessWidget {
  final Uint8List filePath;
  const ProfilePictureView({super.key,required this.filePath});

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            height: 120,
            width: 120,
            color: AppColor.grey.withOpacity(0.2),
            child: Image.memory(
              filePath,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.person,
                  size: 28,
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Dialog(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.pop(context);
                                profileBloc.add(PickImageSourceEvent(ImageSource.camera));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.camera),
                                    width(10),
                                    const Text(
                                      "Camera",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Divider(color: Colors.black.withOpacity(0.3)),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.pop(context);
                                profileBloc.add(PickImageSourceEvent(ImageSource.gallery));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.photo_album),
                                    width(10),
                                    const Text(
                                      "Gallery",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
              padding: const EdgeInsets.all(4),
              child: Container(
                height: 44,
                width: 44,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: AppColor.grey.withOpacity(0.3)),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.linked_camera_outlined),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
