import 'package:flutter/material.dart';
import 'package:onthegrubv2/models/truck.dart';

class SuggestedSection extends StatelessWidget {
  final List<Truck> trucks;
  final Map<String, dynamic> data;

  const SuggestedSection({Key key, this.trucks, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Icon icon = Icon(data['icon'], size: 36);

    if (this.trucks.isEmpty) {
      return Container(width: 0.0, height: 0.0);
    }

    return GestureDetector(
      onTapUp: (e) {
        if (data['action'] != null) {
          data['action']();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
//        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${data['title']}", style: Theme.of(context).textTheme.headline5),
                        Text("${data['description']}", style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                    icon,
                  ],
                ),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height * .3) - ((MediaQuery.of(context).size.height * .3) * .1),
              width: MediaQuery.of(context).size.width,
              child: SuggestedSectionRow(trucks: trucks),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class SuggestedSectionRow extends StatelessWidget {
  final List<Truck> trucks;

  const SuggestedSectionRow({Key key, @required this.trucks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...this.trucks.map((truck) {
            return Row(
              children: [
                SizedBox(width: 8.0),
                /*Container(
//                  height: MediaQuery.of(context).size.height * .3,
                  child: TruckCard(
                    truck: truck,
                    padding: EdgeInsets.only(left: 8.0),
                  ),
                ),*/
              ],
            );
          })
        ],
      ),
    );
  }
}
