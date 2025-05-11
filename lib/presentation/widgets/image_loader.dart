import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_service_booking_app/core/constants.dart';

class ImageLoader extends StatelessWidget {
  final bool isValidUrl;
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const ImageLoader(
      {super.key,
      required this.isValidUrl,
      required this.imageUrl,
      this.height,
      this.width,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return isValidUrl
        ? Container(
            height: height ?? 100,
            width: width ?? 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultPadding)),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: imageUrl,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kBlackColor),
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Image.asset(
                  "assets/default_image.png",
                  fit: fit ?? BoxFit.fill,
                ),
              ),
            ),
          )
        : Center(
            child: Image.asset(
              "assets/default_image.png",
              fit: BoxFit.fill,
            ),
          );
  }
}
