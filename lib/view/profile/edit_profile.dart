import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_booking/view/authentikasi/login_screen.dart';
import 'package:vaccine_booking/view_model/profile_view_model.dart';
import '../../components/constants.dart';
import '../../components/navigator_fade_transition.dart';
import '../../model/profile/family_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isLoading = false;
  bool isLoad = true;
  bool isInvalid = false;
  bool isInvalid2 = false;
  bool isInvalid3 = false;
  String? name;
  String? nik;
  String? email;
  String? phone;
  String? dateBirth;
  String? address;
  String? idCardAddress;
  String? placeBirth;
  String? gender;
  String? status;
  TextEditingController tanggalLahir = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController nikEditingController = TextEditingController();
  TextEditingController tempatLahirEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController alamatKTPEditingController = TextEditingController();
  TextEditingController alamatDomisiliEditingController =
      TextEditingController();

  @override
  void dispose() {
    tanggalLahir.dispose();
    nameEditingController.dispose();
    nikEditingController.dispose();
    tempatLahirEditingController.dispose();
    emailEditingController.dispose();
    phoneEditingController.dispose();
    alamatKTPEditingController.dispose();
    alamatDomisiliEditingController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileViewModel>(context);

    if (isLoad == true) {
      if (user.userData.isEmpty) {
        dateBirth = '';
        name = '';
        nik = '';
        placeBirth = '';
        email = '';
        phone = '';
        idCardAddress = '';
        address = '';
        status = '';
        gender = '';
        tanggalLahir.text = '';
        nameEditingController.text = '';
        nikEditingController.text = '';
        tempatLahirEditingController.text = '';
        emailEditingController.text = '';
        phoneEditingController.text = '';
        alamatKTPEditingController.text = '';
        alamatDomisiliEditingController.text = '';
      } else {
        if (user.userData[0].dateBirth != null) {
          tanggalLahir.text = user.userData[0].dateBirth!;
          dateBirth = user.userData[0].dateBirth!;
        } else {
          tanggalLahir.text = '';
          dateBirth = '';
        }
        if (user.userData[0].name != null) {
          nameEditingController.text = user.userData[0].name!;
          name = user.userData[0].name!;
        } else {
          nameEditingController.text = '';
          name = '';
        }
        if (user.userData[0].nik != null) {
          nikEditingController.text = user.userData[0].nik!;
          nik = user.userData[0].nik!;
        } else {
          nikEditingController.text = '';
          nik = '';
        }
        if (user.userData[0].placeBirth != null) {
          tempatLahirEditingController.text = user.userData[0].placeBirth!;
          placeBirth = user.userData[0].placeBirth!;
        } else {
          tempatLahirEditingController.text = '';
          placeBirth = '';
        }
        if (user.userData[0].email != null) {
          emailEditingController.text = user.userData[0].email!;
          email = user.userData[0].email!;
        } else {
          emailEditingController.text = '';
          email = '';
        }
        if (user.userData[0].phone != null) {
          phoneEditingController.text = user.userData[0].phone!;
          phone = user.userData[0].phone!;
        } else {
          phoneEditingController.text = '';
          phone = '';
        }
        if (user.userData[0].idCardAddress != null) {
          alamatKTPEditingController.text = user.userData[0].idCardAddress!;
          idCardAddress = user.userData[0].idCardAddress!;
        } else {
          alamatKTPEditingController.text = '';
          idCardAddress = '';
        }
        if (user.userData[0].address != null) {
          alamatDomisiliEditingController.text = user.userData[0].address!;
          address = user.userData[0].address!;
        } else {
          alamatDomisiliEditingController.text = '';
          address = '';
        }
        if (user.userData[0].statusFamily != null) {
          status = user.userData[0].statusFamily!.toLowerCase();
        }
        if (user.userData[0].gender != null) {
          gender = user.userData[0].gender!.toLowerCase();
        }
      }
      isLoad = false;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(gradient: gradientHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * 0.17,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          'assets/icons/arrow_back.svg',
                          color: Colors.white,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Text(
                        "Profile",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/icons/account.svg',
                          width: 72,
                          height: 72,
                          color: secondColor,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            nameField(),
                            const SizedBox(
                              height: 16,
                            ),
                            nikField(),
                            const SizedBox(
                              height: 16,
                            ),
                            tempatLahirField(),
                            const SizedBox(
                              height: 16,
                            ),
                            dateField(
                                controller: tanggalLahir,
                                hintText: 'Tanggal Lahir',
                                assetIcon: 'assets/icons/datetime.svg'),
                            const SizedBox(
                              height: 16,
                            ),
                            genderField(
                                hintText: 'Jenis Kelamn',
                                assetIcon: 'assets/icons/gender.svg',
                                item: user.itemsGender),
                            const SizedBox(
                              height: 16,
                            ),
                            emailField(
                                controller: emailEditingController,
                                hintText: 'Alamat Email',
                                assetIcon: 'assets/icons/envelop.svg'),
                            const SizedBox(
                              height: 16,
                            ),
                            phoneField(),
                            const SizedBox(
                              height: 16,
                            ),
                            statusField(
                                hintText: 'Status Keluarga',
                                assetIcon: 'assets/icons/status.svg',
                                item: user.itemsStatus),
                            const SizedBox(
                              height: 16,
                            ),
                            alamatKTPField(),
                            const SizedBox(
                              height: 16,
                            ),
                            alamatDomisiliField(),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: name == null ||
                                  name!.isEmpty ||
                                  placeBirth == null ||
                                  placeBirth!.isEmpty ||
                                  idCardAddress == null ||
                                  idCardAddress!.isEmpty ||
                                  address == null ||
                                  address!.isEmpty ||
                                  nik == null ||
                                  nik!.isEmpty ||
                                  phone == null ||
                                  phone!.isEmpty ||
                                  email == null ||
                                  email!.isEmpty ||
                                  dateBirth == null ||
                                  dateBirth!.isEmpty ||
                                  gender == null ||
                                  gender!.isEmpty ||
                                  status == null ||
                                  status!.isEmpty
                              ? ElevatedButton(
                                  onPressed: null,
                                  child: Text(
                                    "Simpan",
                                    style:
                                        TextStyle(color: Colors.grey.shade300),
                                  ),
                                )
                              : ElevatedButton(
                                  child: isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Simpan",
                                        ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      if (isLoading) return;
                                      setState(() => isLoading = true);

                                      List<FamilyModel> contains = user.userData
                                          .where(
                                            (element) => element.nik!.contains(
                                                nikEditingController.text),
                                          )
                                          .toList();
                                      final id =
                                          user.userData[0].profile!['user_id'];
                                      if (contains.isEmpty ||
                                          contains[0].nik ==
                                              nikEditingController.text) {
                                        await Future.delayed(
                                          const Duration(seconds: 1),
                                        )
                                            .then(
                                              (_) => setState(
                                                  () => isLoading = false),
                                            )
                                            .then(
                                              (_) async {
                                                await user.editFamily(
                                                    FamilyModel(
                                                      name:
                                                          nameEditingController
                                                              .text,
                                                      nik: nikEditingController
                                                          .text,
                                                      email:
                                                          emailEditingController
                                                              .text,
                                                      phone:
                                                          phoneEditingController
                                                              .text,
                                                      gender:
                                                          gender!.toUpperCase(),
                                                      dateBirth:
                                                          tanggalLahir.text,
                                                      address:
                                                          alamatDomisiliEditingController
                                                              .text,
                                                      idCardAddress:
                                                          alamatKTPEditingController
                                                              .text,
                                                      placeBirth:
                                                          tempatLahirEditingController
                                                              .text,
                                                      statusFamily:
                                                          status!.toUpperCase(),
                                                      profile: {"user_id": id},
                                                    ),
                                                    user.userData[0].id!);
                                              },
                                            )
                                            .then(
                                              (_) => Fluttertoast.showToast(
                                                  msg:
                                                      "Berhasil mengubah data diri, silahkan login kembali"),
                                            )
                                            .then(
                                              (_) => user.familyList.clear(),
                                            )
                                            .then(
                                              (_) => user.userData.clear(),
                                            )
                                            .then((_) => isTrue = true)
                                            .then(
                                              (_) => Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushAndRemoveUntil(
                                                NavigatorFadeTransition(
                                                  child: const LoginScreen(),
                                                ),
                                                ModalRoute.withName('/home'),
                                              ),
                                            );
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'NIK Sudah Digunakan');
                                      }
                                    }
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
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

  Widget dateField({controller, assetIcon, hintText}) {
    return Row(
      children: [
        SvgPicture.asset(
          assetIcon,
          color: primaryColor,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: 45,
            child: GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2023),
                );

                if (pickedDate != null) {
                  setState(
                    () {
                      tanggalLahir.text =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      dateBirth = DateFormat('dd-MM-yyyy').format(pickedDate);
                    },
                  );
                }
              },
              child: TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade700),
                enabled: false,
                cursorColor: Colors.white,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  suffixIconConstraints:
                      const BoxConstraints(minHeight: 24, minWidth: 24),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SvgPicture.asset(
                      'assets/icons/suffix.svg',
                      color: Colors.grey,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(
                      top: 8, left: 16, bottom: 8, right: 8),
                  hintText: hintText,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey.shade400),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: pressedColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: pressedColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                textInputAction: TextInputAction.next,
                controller: tanggalLahir,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget nikField() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/badge.svg',
          color: primaryColor,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: isInvalid ? 70 : 45,
            child: TextFormField(
              onChanged: (value) => setState(() => nik = value),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey.shade700),
              cursorColor: Colors.white,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 8, left: 16, bottom: 8, right: 8),
                hintText: "Nomor NIK",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade400),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              textInputAction: TextInputAction.next,
              controller: nikEditingController,
              validator: (value) {
                if (value!.length < 16) {
                  setState(() {
                    isInvalid = true;
                  });
                  return "use valid nik";
                }
                setState(() {
                  isInvalid = false;
                });
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget phoneField() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/phone.svg',
          color: primaryColor,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: isInvalid3 ? 70 : 45,
            child: TextFormField(
              onChanged: (value) => setState(() => phone = value),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey.shade700),
              cursorColor: Colors.white,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(13),
              ],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 8, left: 16, bottom: 8, right: 8),
                hintText: "Nomor hp",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade400),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              textInputAction: TextInputAction.next,
              controller: phoneEditingController,
              validator: (value) {
                if (value!.length < 11) {
                  setState(() {
                    isInvalid3 = true;
                  });
                  return "use valid phone number";
                }
                setState(() {
                  isInvalid3 = false;
                });
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget emailField({controller, assetIcon, hintText}) {
    return Row(
      children: [
        SvgPicture.asset(
          assetIcon,
          color: primaryColor,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: isInvalid2 ? 70 : 45,
            child: TextFormField(
              onChanged: (value) => setState(() => email = value),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey.shade700),
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 8, left: 16, bottom: 8, right: 8),
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade400),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              textInputAction: TextInputAction.next,
              controller: controller,
              validator: (value) {
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value!)) {
                  setState(() {
                    isInvalid2 = true;
                  });
                  return "Use valid email";
                }
                setState(() {
                  isInvalid2 = false;
                });
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget nameField() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/user.svg',
          color: primaryColor,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(25),
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z ]"),
                ),
              ],
              onChanged: (value) => setState(() => name = value),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey.shade700),
              cursorColor: Colors.white,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 8, left: 16, bottom: 8, right: 8),
                hintText: "Nama Lengkap",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade400),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              textInputAction: TextInputAction.next,
              controller: nameEditingController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Required";
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget tempatLahirField() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/address.svg',
          color: primaryColor,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(25),
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z ]"),
                ),
              ],
              onChanged: (value) => setState(() => placeBirth = value),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey.shade700),
              cursorColor: Colors.white,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 8, left: 16, bottom: 8, right: 8),
                hintText: "Tempat Lahir",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade400),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              textInputAction: TextInputAction.next,
              controller: tempatLahirEditingController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Required";
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget alamatKTPField() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/address.svg',
          color: primaryColor,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(255),
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z0-9 ]"),
                ),
              ],
              onChanged: (value) => setState(() => idCardAddress = value),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey.shade700),
              cursorColor: Colors.white,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 8, left: 16, bottom: 8, right: 8),
                hintText: "Alamat Berdasarkan KTP",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade400),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              textInputAction: TextInputAction.next,
              controller: alamatKTPEditingController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Required";
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget alamatDomisiliField() {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/address.svg',
          color: primaryColor,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(255),
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z0-9 ]"),
                ),
              ],
              onChanged: (value) => setState(() => address = value),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.grey.shade700),
              cursorColor: Colors.white,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 8, left: 16, bottom: 8, right: 8),
                hintText: "Alamat Domisili",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade400),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: pressedColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              textInputAction: TextInputAction.next,
              controller: alamatDomisiliEditingController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Required";
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget genderField({assetIcon, hintText, item}) {
    return Row(
      children: [
        SvgPicture.asset(
          assetIcon,
          color: primaryColor,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            height: 45,
            padding:
                const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(
                  hintText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey.shade400),
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade400),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade400,
                ),
                value: gender,
                items:
                    item.map<DropdownMenuItem<String>>(buildMenuItem).toList(),
                onChanged: (value) => setState(
                  () => gender = value.toString(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget statusField({assetIcon, hintText, item}) {
    return Row(
      children: [
        SvgPicture.asset(
          assetIcon,
          color: primaryColor,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            height: 45,
            padding:
                const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(
                  hintText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey.shade400),
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade400),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade400,
                ),
                value: status,
                items:
                    item.map<DropdownMenuItem<String>>(buildMenuItem).toList(),
                onChanged: (value) => setState(
                  () => status = value.toString(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey.shade700),
      ),
    );
  }
}
