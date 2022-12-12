import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sgtours/pages/user/favourite/FavouritePage.dart';


class AddReview extends StatefulWidget {
  const AddReview({Key? key}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  double? _ratingValue;
    final TextEditingController _Textcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Rating & Review'),
        ),
         body: SafeArea(
          child: SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: Column(
              children: [
                Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
          height: 180,
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Image.asset(
                'lib/images/home_sgmuseum.jpg',
                fit: BoxFit.cover,
              ))),
    ),
                // implement the rating bar
                // Display the rate in number
                Padding(
                   padding: const EdgeInsets.only(top: 20.0),
                child:
                RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue = value;
                      });
                    }),
                ),
                // Display the rate in number
                /* pls keep this code for my reference
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  
                  child: Text(
                    _ratingValue != null ? _ratingValue.toString() : 'Rate it!',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),*/
                
                Padding(
              padding: const EdgeInsets.all(20.0),
              child:TextFormField(
                controller: _Textcontroller,
                minLines: 5,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(
                    color: Colors.grey
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
                ),
              ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavouritePage())
                              );
                    },
                    child: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 20),
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ))
          ));
  }
}