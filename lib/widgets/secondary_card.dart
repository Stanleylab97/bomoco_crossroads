import 'package:bomoco/config/constants.dart';
import 'package:bomoco/models/article.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecondaryCard extends StatelessWidget {
  final Article news;
  SecondaryCard({this.news});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(top: 4.0, bottom: 0, left: 3.0, right: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: kGrey3, width: 1.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kTitleCard,
                  ),
                  SizedBox(height: 1.0),
                  Text(
                    news.subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kDetailContent,
                    textAlign: TextAlign.start,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.clock),
                          SizedBox(width: 2.0),
                          Text(news.publishedAt, style: kDetailContent),
                        ],
                      ),
                      Text(
                        "${news.author}",
                        style: kDetailContent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Container(
            width: size.width * .25,
            height: size.height * .25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: NetworkImage(news.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
