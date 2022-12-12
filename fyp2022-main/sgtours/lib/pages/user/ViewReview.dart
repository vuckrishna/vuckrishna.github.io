import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:sgtours/model/reviews.dart';


class ViewReview extends StatefulWidget {
  ViewReview({Key? key}) : super(key: key);

  @override
  State<ViewReview> createState() => _ViewReviewState();
}

class _ViewReviewState extends State<ViewReview> {
  var rating = 4.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('Reviews',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ))),
      body: SingleChildScrollView(
        child: Padding(
                                  padding: const EdgeInsets.symmetric( vertical: 16.0,
                                 horizontal: 16.0),
        child: ListView.separated(
                            separatorBuilder: (BuildContext context, int index) =>
                                const SizedBox(height: 3),
                            itemCount: ReviewList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 45.0,
                          width: 45.0,
                          margin: EdgeInsets.only(right: 16.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ReviewList[index].url),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(45.0),
                          ),
                        ),
                        Text(ReviewList[index].name,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    SmoothStarRating(
                        color: Colors.red,
                        borderColor: Colors.red,
                        rating: rating,
                        // isReadOnly: true,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        size: 20.0),
                    SizedBox(height: 8.0),
                    Text(
                        ReviewList[index].review,
                        style: TextStyle(fontSize: 13.0)),
                  ],
                ),
              );
                            }
        )
      )
      )
      );
  }
}
