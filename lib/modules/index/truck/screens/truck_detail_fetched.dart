import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:onthegrubv2/modules/index/truck/bloc/trucks_cubit.dart';
import 'package:onthegrubv2/modules/index/truck/models/truck.dart';
import 'package:onthegrubv2/utils/helpers/url_helper.dart';

class TruckDetailFetchedScreen extends StatelessWidget {
  final BuildContext context;
  final TruckFetched state;

  const TruckDetailFetchedScreen(this.context, this.state);

  @override
  Widget build(BuildContext context) {
    Truck truck = state.truck;

    return Container(
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.of(context).pushNamed('/Menu');
      //   },
      //   isExtended: true,
      //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //   icon: Icon(Icons.restaurant),
      //   label: Text('Menu'),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                expandedHeight: 300,
                elevation: 0,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Hero(
                    tag: truck.pk,
                    child: Image.network(
                      truck.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Wrap(
//              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              truck.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.display2,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(8),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(truck.rating ?? "no ratings",
                                    style: Theme.of(context)
                                        .textTheme
                                        .body2
                                        .merge(TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor))),
                                if (truck.rating != null)
                                  Icon(
                                    Icons.star_border,
                                    color: Theme.of(context).primaryColor,
                                    size: 18,
                                  ),
                              ],
                            ),
                            color:
                                Theme.of(context).accentColor.withOpacity(0.9),
                            shape: StadiumBorder(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(truck.description),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                truck.address ?? "no address",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ),
                            SizedBox(width: 10),
                            if (truck.address != null)
                              SizedBox(
                                width: 42,
                                height: 42,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () async {
                                    final availableMaps =
                                        await MapLauncher.installedMaps;
                                    print(
                                        availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                                    // Geocode address
                                    var addresses = await Geocoder.local
                                        .findAddressesFromQuery(truck.address);
                                    double latitude =
                                        addresses.first.coordinates.latitude;
                                    double longitude =
                                        addresses.first.coordinates.longitude;

                                    await availableMaps.first.showMarker(
                                      coords: Coords(latitude, longitude),
                                      title: truck.title,
                                    );
                                  },
                                  child: Icon(
                                    Icons.directions,
                                    color: Theme.of(context).primaryColor,
                                    size: 24,
                                  ),
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.9),
                                  shape: StadiumBorder(),
                                ),
                              ),
                          ],
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${truck.phone ?? "no phone number"}',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          SizedBox(width: 10),
                          if (truck.phone != null)
                            SizedBox(
                              width: 42,
                              height: 42,
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  launchCall(truck.phone);
                                },
                                child: Icon(
                                  Icons.call,
                                  color: Theme.of(context).primaryColor,
                                  size: 24,
                                ),
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.9),
                                shape: StadiumBorder(),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // TODO: Add reviews
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 10, horizontal: 20),
                    //   child: ListTile(
                    //     dense: true,
                    //     contentPadding: EdgeInsets.symmetric(vertical: 0),
                    //     leading: Icon(
                    //       Icons.recent_actors,
                    //       color: Theme
                    //           .of(context)
                    //           .hintColor,
                    //     ),
                    //     title: Text(
                    //       'What They Say ?',
                    //       style: Theme
                    //           .of(context)
                    //           .textTheme
                    //           .display1,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20, vertical: 10),
                    //   child: ReviewsListWidget(),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: ListTile(
                    //     dense: true,
                    //     contentPadding: EdgeInsets.symmetric(vertical: 0),
                    //     leading: Icon(
                    //       Icons.restaurant,
                    //       color: Theme
                    //           .of(context)
                    //           .hintColor,
                    //     ),
                    //     title: Text(
                    //       'Featured Foods',
                    //       style: Theme
                    //           .of(context)
                    //           .textTheme
                    //           .display1,
                    //     ),
                    //   ),
                    // ),
                    // ListView.separated(
                    //   padding: EdgeInsets.symmetric(vertical: 10),
                    //   scrollDirection: Axis.vertical,
                    //   shrinkWrap: true,
                    //   primary: false,
                    //   itemCount: _ordersList.recentOrderedList.length,
                    //   separatorBuilder: (context, index) {
                    //     return SizedBox(height: 10);
                    //   },
                    //   itemBuilder: (context, index) {
                    //     return OrderItemWidget(
                    //       heroTag: 'details_featured_food',
                    //       order: _ordersList.recentOrderedList.elementAt(index),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
