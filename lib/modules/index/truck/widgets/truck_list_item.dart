import 'package:flutter/material.dart';
import 'package:onthegrubv2/constants/assets_path.dart';
import 'package:onthegrubv2/modules/index/truck/models/truck.dart';

class TruckListItemWidget extends StatelessWidget {
  final Truck truck;

  TruckListItemWidget({this.truck});

  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.pushNamed(context, '/trucks/${truck.pk}');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: truck.image != null
                    ? DecorationImage(image: NetworkImage(truck.image), fit: BoxFit.cover)
                    : DecorationImage(image: AssetImage(Assets.foodTruck)),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          truck.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          truck.address ?? "",
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  // Text(food.getPrice(),
                  //     style: Theme.of(context).textTheme.display1),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
