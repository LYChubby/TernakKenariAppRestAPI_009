import 'package:canary_template/core/core.dart';
import 'package:canary_template/data/models/response/buyer/buyer_profile_response_model.dart';
import 'package:canary_template/presentation/buyer/home/buyer_home_screen.dart';
import 'package:flutter/material.dart';

class ProfileViewBuyer extends StatelessWidget {
  final Data profile;
  const ProfileViewBuyer({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nama: ${profile.name}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Alamat: ${profile.address}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            Text(
              "No. HP: ${profile.phone}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.pushAndRemoveUntil(
                  const BuyerHomeScreen(),
                  (route) => false,
                );
              },
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
