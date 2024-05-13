import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

final Color shimmerbaseColor = Colors.grey[300]!;
final Color shimmerHighlightColor = Colors.grey[100]!;

Widget getShimmer({
  double height = 12,
  double width = 40,
  double itemElevation = 0,
  double itemBorderRadius = 5,
}) {
  return Shimmer.fromColors(
    baseColor: shimmerbaseColor,
    highlightColor: shimmerHighlightColor,
    child: Card(
      elevation: itemElevation,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(itemBorderRadius),
      ),
      child: SizedBox(
        height: height,
        width: width,
      ),
    ),
  );
}

Widget shimmerHorizontalList({
  double itemSpacing = 30,
  double itemHeight = 150,
  double itemWidth = 250,
  int itemCount = 10,
  double itemBorderRadius = 5,
}) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    clipBehavior: Clip.hardEdge,
    itemCount: itemCount,
    separatorBuilder: (BuildContext context, int index) {
      return SizedBox(
        width: itemSpacing,
      );
    },
    itemBuilder: (context, index) {
      return getShimmer(
        height: itemHeight,
        width: itemWidth,
        itemBorderRadius: itemBorderRadius,
      );
    },
  );
}

Shimmer shimmerTableEffect({
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  double itemHeight = 40,
  int itemCount = 20,
  double itemBorderRadius = 20,
}) {
  return Shimmer.fromColors(
    baseColor: shimmerbaseColor,
    highlightColor: shimmerHighlightColor,
    child: Padding(
      padding: padding,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            endIndent: 0,
            color: Colors.black,
            height: 0,
            indent: 0,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(itemBorderRadius)),
            ),
            child: SizedBox(
              height: itemHeight,
            ),
          );
        },
      ),
    ),
  );
}

Shimmer shimmerGridEffect({
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  double itemAspectRatio = 1,
  int itemCount = 20,
  double itemBorderRadius = 5,
  int crossAxisCount = 2,
  bool shrinkWrap = true,
}) {
  return Shimmer.fromColors(
    baseColor: shimmerbaseColor,
    highlightColor: shimmerHighlightColor,
    child: Padding(
      padding: padding,
      child: GridView.builder(
        shrinkWrap: shrinkWrap,
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: itemAspectRatio,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(itemBorderRadius),
            ),
            child: const SizedBox(),
          );
        },
      ),
    ),
  );
}
