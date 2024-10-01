import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        highlightColor: Colors.grey[100]!,
        baseColor: Colors.grey[300]!,
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: Constants.cardMarginHorizontal),
                Container(
                  height: Constants.textPrimary,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: const BoxDecoration(
                    borderRadius:  BorderRadius.all(
                        Radius.circular(Constants.minRadius)),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: Constants.padding),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:  BorderRadius.all(
                        Radius.circular(Constants.minRadius)),
                    color: Colors.white,
                  ),
                  height: Constants.textPrimary,
                  width: double.infinity,
                ),
                const SizedBox(height: Constants.padding),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Constants.minRadius)),
                    color: Colors.white,
                  ),
                  height: Constants.textPrimary,
                  width: 240,
                ),
                const SizedBox(height: Constants.cardMarginHorizontal),
              ],
            ),
          );
        }));
  }
}