import 'package:bomoco/config/constants.dart';
import 'package:bomoco/models/article.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrimaryCard extends StatelessWidget {
  final Article news;

  PrimaryCard({this.news});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .6,
      
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: kGrey3, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 5.0,
                backgroundColor: kGrey1,
              ),
              SizedBox(width: 10.0),
              Text(news.category, style: kCategoryTitle)
            ],
          ),
          SizedBox(height: 5.0),
          Expanded(
            child: Hero(
              tag: news.seen,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(news.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            news.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: kPrimaryTitleCard,
          ),
          SizedBox(height: 5.0),
          Row(
            children: [
              SizedBox(width: 10.0),
              FaIcon(FontAwesomeIcons.clock),
              SizedBox(width: 8.0),
              Text("${news.publishedAt} min ago", style: kDetailContent)
            ],
          )
        ],
      ),
    );
  }
}
