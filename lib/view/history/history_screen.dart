import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_booking/components/navigator_fade_transition.dart';
import 'package:vaccine_booking/view/history/history_vaccine_screen.dart';
import 'package:vaccine_booking/view_model/history_view_model.dart';
import 'package:vaccine_booking/view_model/profile_view_model.dart';

import '../../components/constants.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final history = Provider.of<HistoryViewModel>(context);
    final user = Provider.of<ProfileViewModel>(context);
    if (history.filterDetailBookingList.isEmpty &&
        user.filterUserProfile.isNotEmpty) {
      Provider.of<HistoryViewModel>(context).filterDetailBooking(
        user.filterUserProfile[0].profile['user_id'],
      );
    }
    if (history.filterNameBooking.isEmpty) {
      Provider.of<HistoryViewModel>(context).filterBookingName();
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: gradientHorizontal),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              headline(context),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 22,
                      ),
                      Text(
                        "Tiket Vaksin",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: historyNameList(history),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headline(context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          "Pesan Vaksinasi",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget historyNameList(HistoryViewModel history) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.white,
          height: 16,
        );
      },
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Center(
          child: Container(
            height: 55,
            decoration: const BoxDecoration(
              color: secondColorLow,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: TextButton(
              onPressed: () {
                history.filterDetailVaksinasiOrder.clear();
                Navigator.of(context).push(
                  NavigatorFadeTransition(
                    child: HistoryVaccineScreen(
                      history: history.filterNameBooking[index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      history.filterNameBooking[index].family!['name'],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: 36,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: history.filterNameBooking.length,
    );
  }
}
