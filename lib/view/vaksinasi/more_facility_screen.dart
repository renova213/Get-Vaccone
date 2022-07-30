import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_booking/components/constants.dart';
import 'package:vaccine_booking/components/navigator_fade_transition.dart';
import 'package:vaccine_booking/view/vaksinasi/vaksinasi_booking_screen.dart';

import '../../components/skeleton_container.dart';
import '../../view_model/profile_view_model.dart';
import '../../view_model/vaksinasi_view_model.dart';
import '../profile/edit_profile.dart';

class MoreFacilityScreen extends StatefulWidget {
  final String? query;
  const MoreFacilityScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<MoreFacilityScreen> createState() => _MoreFacilityScreenState();
}

class _MoreFacilityScreenState extends State<MoreFacilityScreen> {
  bool isInit = true;
  String moreQuery = '';
  bool isExpand = false;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isInit == true) {
      Provider.of<VaksinasiViewModel>(context, listen: false)
          .searchMoreFacility(query: moreQuery);
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final healthFacilities = Provider.of<VaksinasiViewModel>(context);
    final user = Provider.of<ProfileViewModel>(context);
    setState(() {
      healthFacilities.searchMoreFacility(
          query: moreQuery, query2: widget.query);
    });
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 35,
          title: isExpand
              ? Row(
                  children: [
                    Expanded(
                      child: searchTextField(healthFacilities),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              setState(
                                () {
                                  searchController.clear();
                                  moreQuery = searchController.text;
                                  healthFacilities.searchMoreFacility(
                                      query: moreQuery);
                                },
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: SvgPicture.asset(
                              'assets/icons/arrow_back.svg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Fasilitas Kesehatan",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, right: 12),
                      child: Material(
                        color: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                isExpand = true;
                              },
                            );
                          },
                          icon: const Icon(
                            CupertinoIcons.search,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding, top: defaultPadding, right: defaultPadding),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              location(context),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height,
                child: listFacility(healthFacilities, user),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listFacility(
      VaksinasiViewModel healthFacilities, ProfileViewModel user) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1.8,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    child: Image.memory(
                      convertBase64Image(moreQuery.isEmpty
                          ? healthFacilities.result[index].image['base64']
                          : healthFacilities.moreResult[index].image['base64']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            moreQuery.isEmpty
                                ? Text(
                                    healthFacilities
                                        .result[index].facilityName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.black),
                                  )
                                : Text(
                                    healthFacilities
                                        .moreResult[index].facilityName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.black),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/reserve.svg',
                                    width: 16, height: 16, color: primaryColor),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Kuota Tersedia",
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.20,
                        bottom: 0,
                        right: 0,
                        child: buttonText(
                            context,
                            moreQuery.isEmpty
                                ? healthFacilities.result[index]
                                : healthFacilities.moreResult[index],
                            moreQuery.isEmpty
                                ? healthFacilities.result[index].id
                                : healthFacilities.moreResult[index].id,
                            user),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: moreQuery.isEmpty
            ? healthFacilities.result.length
            : healthFacilities.moreResult.length);
  }

  Widget buttonText(context, facilities, id, ProfileViewModel user) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            if (user.userData[0].name != null &&
                user.userData[0].phone != null) {
              Navigator.of(context).push(
                NavigatorFadeTransition(
                  child: VaksinasiBookingScreen(
                    facilities: facilities,
                    id: id,
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
          child: Text(
            'Selengkapnya',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: primaryColor),
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_right,
          color: primaryColor,
          size: 14,
        ),
      ],
    );
  }

  Widget location(context) {
    return Padding(
      padding: const EdgeInsets.only(left: defaultPadding),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/location.svg',
            width: 20,
            height: 20,
            color: primaryColor,
          ),
          const SizedBox(
            width: 8,
          ),
          widget.query!.isEmpty
              ? Text(
                  'all health of facility',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                )
              : moreQuery.isEmpty
                  ? Text(
                      widget.query!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                    )
                  : Text(
                      moreQuery,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                    ),
        ],
      ),
    );
  }

  Widget searchTextField(VaksinasiViewModel healthFacilities) {
    return TextField(
      onSubmitted: (value) => setState(
        () {
          moreQuery = value;
          healthFacilities.searchMoreFacility(query: moreQuery);
        },
      ),
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: Colors.grey.shade800),
      controller: searchController,
      decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: IconButton(
              onPressed: () {
                setState(
                  () {
                    isExpand = false;
                    searchController.clear();
                  },
                );
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.grey,
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 8),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.grey.shade400),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'search'),
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

  Widget imageSkeleton() {
    return SkeletonContainer(
      borderRadius: 15,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.33,
    );
  }
}
