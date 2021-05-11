import 'package:flutter/material.dart';
import 'package:onthegrubv2/core/auth/models/user.dart';

class UserCard extends StatelessWidget {
  final User _user;
  UserCard(this._user);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .2,
      width: size.width * .75,
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                // User image
                Image.network(
                  _user.profilePicture,
                  height: size.height * .05,
                  width: size.width * .1,
                ),
                Column(
                  children: [
                    // Name followed by username
                    Row(
                      children: [
                        _user.firstName != null ? Text(_user.firstName + " " + _user.lastName) : GestureDetector(child: Text("Add name")),
                        Text(_user.username),
                      ],
                    ),

                    // Type of user followed by edit profile button
                    Row(
                      children: [
                        // TODO: check if "Truck owner" matches site
                        Text(_user.trucks.length < 0 ? "Foodie" : "Truck owner"),
                      ],
                    )
                  ],
                )
              ],
            ),
            // Buttons -> Review, Trucks, Favorites
            Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
