import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onthegrubv2/models/truck.dart';
import 'package:onthegrubv2/models/user.dart';
import 'package:provider/provider.dart';

class TruckListItem extends StatefulWidget {
  final Truck truck;
  final User user;
  static const double CARD_HEIGHT = 200.0;

  const TruckListItem({this.truck, this.user});

  State<StatefulWidget> createState() => _TruckListItemState();
}

class _TruckListItemState extends State<TruckListItem> {
  @override
  Widget build(BuildContext context) {
    bool _isFavorited = widget.user.hasFavorited(widget.truck.pk);
//    LocationBloc listenLocationBloc = Provider.of<LocationBloc>(context);

    return GestureDetector(
      key: Key(widget.truck.title),
      onTap: () {
//        Navigator.pushNamed(context, TruckProfile.routeName, arguments: widget.truck);
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).dividerColor, width: 1.0),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Container(
          height: TruckListItem.CARD_HEIGHT,
          padding: EdgeInsets.zero,
          child: Stack(
            children: <Widget>[
              Image.network(
                widget.truck.image,
                fit: BoxFit.cover,
                height: TruckListItem.CARD_HEIGHT,
                width: double.infinity,
              ),
              Positioned(
                right: 48 / 3 - 4,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(!widget.user.hasFavorited(widget.truck.pk) ? Icons.favorite_border : Icons.favorite,
                      color: Colors.redAccent, size: 48),
                  onPressed: () async {
//                    await toggleFavorite(_isFavorited);
                  },
                ),
              ),
              Positioned(
                left: 4,
                bottom: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black54),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(widget.truck.title, style: Theme.of(context).textTheme.headline5),
                        )),
                  ],
                ),
              ),
              /*if (widget.truck.hasLocation && listenLocationBloc.isListening)
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: TruckDistanceText(truck: widget.truck),
                ),*/
            ],
          ),
        ),
      ),
    );
  }
/*
  Future toggleFavorite(bool _isFavorited) async {
    if (_isFavorited) {
      bool unfav = await widget.user.unfavorite(widget.truck);
      setState(() {
        _isFavorited = unfav;
      });
    } else {
      bool fav = await widget.user.favorite(widget.truck);
      setState(() {
        _isFavorited = fav;
      });
    }
  }*/
}
