import 'package:k31_watch_flutter/common/constants.dart';
import 'package:flutter/material.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    super.key,
    required this.title,
    required this.onTapFunction,
  });

  final String title;
  final void Function()? onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: myTextTheme.titleLarge,
        ),
        InkWell(
          onTap: onTapFunction,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Row(
                    children: [
                      Text(
                        'Clickk To See More',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_sharp, size: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
