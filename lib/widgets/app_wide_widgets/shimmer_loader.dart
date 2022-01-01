import 'package:flutter/material.dart';
import 'package:spinchat/utils/constants/color_constants.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: 7,
      itemBuilder: (_, __) => const Shimmer(),
      separatorBuilder: (_, index) => const Divider(),
    );
  }
}

class Shimmer extends StatelessWidget {
  const Shimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ShimBox(height: 120, width: 120),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShimBox(width: 80),
              const SizedBox(height: 8),
              const ShimBox(),
              const SizedBox(height: 8),
              const ShimBox(),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Expanded(child: ShimBox()),
                  SizedBox(width: 16),
                  Expanded(child: ShimBox()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShimBox extends StatelessWidget {
  const ShimBox({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    final bool _light = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _light ? AppColors.myLightGrey : AppColors.lighterGrey,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
