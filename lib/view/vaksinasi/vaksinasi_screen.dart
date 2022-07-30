import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_booking/components/constants.dart';
import 'package:vaccine_booking/components/navigator_fade_transition.dart';
import 'package:vaccine_booking/view/profile/edit_profile.dart';
import 'package:vaccine_booking/view/vaksinasi/more_facility_screen.dart';
import 'package:vaccine_booking/view/vaksinasi/vaksinasi_booking_screen.dart';
import 'package:vaccine_booking/view_model/profile_view_model.dart';
import 'package:vaccine_booking/view_model/vaksinasi_view_model.dart';

import '../../components/skeleton_container.dart';

class VaksinasiScreen extends StatefulWidget {
  const VaksinasiScreen({Key? key}) : super(key: key);

  @override
  State<VaksinasiScreen> createState() => _VaksinasiScreenState();
}

class _VaksinasiScreenState extends State<VaksinasiScreen> {
  String query = '';
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final healthFacilities = Provider.of<VaksinasiViewModel>(context);
    final user = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: gradientHorizontal),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Text(
                        "Pesan Vaksinasi",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.87,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: defaultPadding, right: defaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              "Pilih lokasi vaksinasi terdekat",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: searchTextField(healthFacilities),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    "Fasilitas kesehatan terdekat",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.037,
                                  width: 97,
                                  child: moreButton(healthFacilities),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: listNearFacility(healthFacilities, user),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget modalDataAlert(context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 385,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:
                      Icon(Icons.close, color: Colors.grey.shade500, size: 32),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.135,
                child: Image.asset('assets/images/warning.png'),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Duh, data dirimu masih belum lengkap!",
                style: Theme.of(context).textTheme.headline2!,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Yuk, lengkapi data profilmu terlebih dahulu sebelum kembali melanjutkan pemesanan.",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade500),
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    child: const Text(
                      "Lengkapi Profil",
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        NavigatorFadeTransition(
                          child: const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget moreButton(VaksinasiViewModel healthFacilities) {
    return ElevatedButton(
      style: lowStateButton,
      onPressed: () {
        Navigator.of(context, rootNavigator: true).push(
          NavigatorFadeTransition(
            child: MoreFacilityScreen(
              query: query,
            ),
          ),
        );
      },
      child: const Text(
        "Lihat Semua",
        style: TextStyle(fontSize: 10),
      ),
    );
  }

  Widget searchTextField(VaksinasiViewModel healthFacilities) {
    return TextField(
      onSubmitted: (value) => setState(
        () {
          String input = value;
          healthFacilities.searchFacility(query: input);
        },
      ),
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: Colors.grey.shade800),
      controller: searchController,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: buttonColorSecondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: pressedColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Cari kota, provinsi, kode pos',
        suffixIcon: SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.height * 0.07,
          child: ElevatedButton(
            onPressed: () {
              setState(
                () {
                  query = searchController.text;
                  healthFacilities.searchFacility(query: query);
                },
              );
            },
            child: const Icon(CupertinoIcons.search),
          ),
        ),
      ),
    );
  }

  Widget listNearFacility(
      VaksinasiViewModel healthFacilities, ProfileViewModel user) {
    return Padding(
      padding:
          const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: query.isEmpty
                  ? healthFacilities.facilityList.length
                  : healthFacilities.result.length,
              itemBuilder: (context, index) {
                if (healthFacilities.facilityList.isEmpty) {
                  return buildSkeleton();
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (user.userData[0].name != null &&
                              user.userData[0].phone != null) {
                            Navigator.of(context, rootNavigator: true).push(
                              NavigatorFadeTransition(
                                child: VaksinasiBookingScreen(
                                  facilities: query.isEmpty
                                      ? healthFacilities.facilityList[index]
                                      : healthFacilities.result[index],
                                  id: query.isEmpty
                                      ? healthFacilities.facilityList[index].id
                                      : healthFacilities.result[index].id,
                                ),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return modalDataAlert(context);
                              },
                            );
                          }
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.23,
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: AspectRatio(
                            aspectRatio: 3.5 / 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.memory(
                                convertBase64Image(query.isEmpty
                                    ? healthFacilities
                                        .facilityList[index].image['base64']
                                    : healthFacilities
                                        .result[index].image['base64']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Flexible(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: query.isEmpty
                              ? Text(
                                  healthFacilities
                                      .facilityList[index].facilityName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.black),
                                )
                              : Text(
                                  healthFacilities.result[index].facilityName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.black),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                              color: primaryColor,
                              height: 20,
                              width: 20,
                              "assets/icons/document_search.svg"),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Kuota Tersedia",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget imageSkeleton() {
    return AspectRatio(
      aspectRatio: 3.5 / 4,
      child: SkeletonContainer(
        borderRadius: 15,
        height: MediaQuery.of(context).size.height * 0.23,
        width: MediaQuery.of(context).size.width * 0.42,
      ),
    );
  }

  Widget buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonContainer(
              height: MediaQuery.of(context).size.height * 0.23,
              width: MediaQuery.of(context).size.width * 0.42,
              borderRadius: 15),
          const SizedBox(
            height: 8,
          ),
          Flexible(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.42,
                child: const SkeletonContainer(
                    width: 100, height: 20, borderRadius: 0)),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: const [
              SkeletonContainer(width: 20, height: 20, borderRadius: 0),
              SizedBox(
                width: 8,
              ),
              SkeletonContainer(width: 100, height: 20, borderRadius: 0),
            ],
          ),
        ],
      ),
    );
  }
}
