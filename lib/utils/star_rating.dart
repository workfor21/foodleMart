import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({Key? key, this.rating = 0, this.iconsize = 15})
      : super(key: key);
  final double iconsize;
  final double rating;

  @override
  Widget build(BuildContext context) {
    const starColor = Colors.yellow;
    return FittedBox(
      child: SizedBox(
        height: 25,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (ctx, index) {
              return rating >= index + 1
                  ? Icon(
                      Icons.star,
                      color: starColor,
                      size: iconsize,
                    )
                  : rating > index
                      ? Icon(
                          Icons.star_half,
                          color: starColor,
                          size: iconsize,
                        )
                      : Icon(
                          Icons.star_border,
                          color: starColor,
                          size: iconsize,
                        );
            }),
      ),
    );
  }
}
