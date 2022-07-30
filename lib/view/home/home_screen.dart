import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vaccine_booking/components/constants.dart';
import 'package:vaccine_booking/components/navigator_fade_transition.dart';
import 'package:vaccine_booking/components/skeleton_container.dart';
import 'package:vaccine_booking/view/vaksinasi/vaksinasi_screen.dart';
import 'package:vaccine_booking/view_model/history_view_model.dart';
import 'package:vaccine_booking/view_model/home_view_model.dart';
import 'package:vaccine_booking/view_model/profile_view_model.dart';

import '../../view_model/vaksinasi_view_model.dart';
import '../profile/edit_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    if (isTrue == true) {
      Provider.of<HomeViewModel>(context, listen: false).getAllNews();
      Provider.of<ProfileViewModel>(context, listen: false).getAllFamilies();
      Provider.of<ProfileViewModel>(context, listen: false).getUsersProfile();
      Provider.of<ProfileViewModel>(context, listen: false).detailProfile();
      Provider.of<VaksinasiViewModel>(context, listen: false)
          .getAllHealthFacilities();
      Provider.of<VaksinasiViewModel>(context, listen: false).getBookingList();
      Provider.of<HistoryViewModel>(context, listen: false).getDetailBooking();
      Provider.of<VaksinasiViewModel>(context, listen: false).getAllSchedule();
      isTrue = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<HomeViewModel>(context);
    final user = Provider.of<ProfileViewModel>(context);
    final schedule = Provider.of<VaksinasiViewModel>(context);
    if (user.userData.isEmpty) {
      Provider.of<ProfileViewModel>(context).filterUser();
    }
    if (user.userFamily.isEmpty) {
      Provider.of<ProfileViewModel>(context).filterUserFamily();
    }
    if (user.filterUserProfile.isEmpty) {
      Provider.of<ProfileViewModel>(context).filterUserData();
    }

    schedule.scheduleIdBooking = 0;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: gradientHorizontal),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Home",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              "Halo,",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            user.userData.isEmpty
                                ? Text(
                                    "null",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.white),
                                  )
                                : Text(
                                    user.userData[0].name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.white),
                                  ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.82,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Center(
                          child: bannerVaksinasi(user),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          "Berita hari ini",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.22,
                          child: newsListView(news),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bannerVaksinasi(ProfileViewModel profile) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
        color: secondColorLow,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: defaultPadding, top: defaultPadding),
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ayo lakukan vaksinasi!",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  profile.gender == "Gender"
                      ? Text(
                          "Harap lengkapi data diri anda sebelum melakukan pemesanan.",
                          style: Theme.of(context).textTheme.bodyText2!)
                      : Text("Kamu sudah dapat melakukan pemesanan vaksinasi.",
                          style: Theme.of(context).textTheme.bodyText2!),
                  const SizedBox(
                    height: 16,
                  ),
                  profile.gender == "Gender"
                      ? SizedBox(
                          height: 25,
                          width: 145,
                          child: lengkapiDataButton(),
                        )
                      : SizedBox(
                          height: 25,
                          width: 155,
                          child: vaksinasiButton(),
                        ),
                ],
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              bottom: 12,
              child: Image.asset(
                'assets/images/vaccine2.png',
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newsListView(HomeViewModel viewModel) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.white,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) {
        if (viewModel.newsList.isEmpty) {
          return buildSkeleton();
        }
        return GestureDetector(
          onTap: () {
            try {
              launchUrl(
                Uri.parse(viewModel.newsList[index].url),
              );
            } catch (_) {
              Fluttertoast.showToast(msg: 'Something Wrong');
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        viewModel.newsList[index].urlToImage),
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, bottom: 8.0, right: 8),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    viewModel.newsList[index].title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget lengkapiDataButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).push(
          NavigatorFadeTransition(
            child: const EditProfileScreen(),
          ),
        );
      },
      child: const Text(
        "Lengkapi Data Diri",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  Widget vaksinasiButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).push(
          NavigatorFadeTransition(
            child: const VaksinasiScreen(),
          ),
        );
      },
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          "Pesan Vaksinasi Disini",
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: SkeletonContainer(
        borderRadius: 15,
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.6,
      ),
    );
  }

  Widget textSkeleton() {
    return SkeletonContainer(
      borderRadius: 0,
      height: MediaQuery.of(context).size.height * 0.03,
      width: MediaQuery.of(context).size.width * 0.3,
    );
  }
}
