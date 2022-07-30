import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../components/constants.dart';
import '../../model/profile/family_model.dart';
import '../../view_model/profile_view_model.dart';

class RegisterFamilyScreen extends StatefulWidget {
  const RegisterFamilyScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterFamilyScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterFamilyScreen> {
  var obscureText = true;
  bool isLoading = false;
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/icons/arrow_back.svg',
                      width: 36,
                      height: 36,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Tambah Anggota Keluarga",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textFieldName("NIK"),
                        const SizedBox(height: 8),
                        nikField(),
                        const SizedBox(height: 16),
                        //.
                        textFieldName("Nama"),
                        const SizedBox(height: 8),
                        nameField(),
                        const SizedBox(height: 16),
                        //.
                        textFieldName("Tempat Lahir"),
                        const SizedBox(height: 8),
                        tempatLahirField(),
                        const SizedBox(height: 16),
                        //.
                        textFieldName("Tanggal Lahir"),
                        const SizedBox(height: 8),
                        dateField(hintText: 'pilih tanggal'),
                        const SizedBox(height: 16),
                        //.
                        textFieldName("Jenis Kelamin"),
                        const SizedBox(height: 8),
                        genderField(hintText: 'pilih', item: user.itemsGender),
                        const SizedBox(height: 16),
                        //.
                        textFieldName("Hubungan Keluarga"),
                        const SizedBox(height: 8),
                        statusField(hintText: 'pilih', item: user.itemsStatus),
                        const SizedBox(height: 16),
                        //.
                        textFieldName("Email"),
                        const SizedBox(height: 8),
                        emailField(hintText: "Alamat email"),
                        const SizedBox(height: 16),
                        //.
                        textFieldName("No. HP"),
                        const SizedBox(height: 8),
                        phoneField(),
                        const SizedBox(height: 16),
                        //.
                        textFieldName("Alamt Berdasarkan KTP"),
                        const SizedBox(height: 8),
                        alamatKTPField(),
                        const SizedBox(height: 16),
                        //.
                        textFieldName("Alamat saat ini"),
                        const SizedBox(height: 8),
                        alamatDomisiliField(),
                        const SizedBox(height: 30),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
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
                                      "REGISTER",
                                      style: TextStyle(
                                          color: Colors.grey.shade300),
                                    ),
                                  )
                                : ElevatedButton(
                                    child: isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            "REGISTER",
                                          ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        if (isLoading) return;
                                        setState(() => isLoading = true);
                                        List<FamilyModel> contains =
                                            user.familyList
                                                .where(
                                                  (element) => element.nik!
                                                      .contains(
                                                          nikEditingController
                                                              .text),
                                                )
                                                .toList();
                                        final id = user
                                            .userData[0].profile!['user_id'];
                                        if (contains.isEmpty) {
                                          try {
                                            Future.delayed(
                                              const Duration(seconds: 0),
                                            )
                                                .then(
                                                  (_) => user.addFamily(
                                                    family: FamilyModel(
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
                                                  ),
                                                )
                                                .then(
                                                  (_) =>
                                                      user.familyList.clear(),
                                                )
                                                .then(
                                                  (_) =>
                                                      user.userFamily.clear(),
                                                )
                                                .then(
                                                  (_) => user.getAllFamilies(),
                                                )
                                                .then(
                                                  (_) => Future.delayed(
                                                    const Duration(seconds: 1),
                                                  ),
                                                )
                                                .then(
                                                  (_) =>
                                                      user.filterUserFamily(),
                                                )
                                                .then(
                                                  (_) => Future.delayed(
                                                    const Duration(seconds: 1),
                                                  ),
                                                )
                                                .then(
                                                  (_) => setState(
                                                      () => isLoading = true),
                                                )
                                                .then(
                                                  (_) => Fluttertoast.showToast(
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      msg:
                                                          "Berhasil Menambahkan Anggota Keluarga"),
                                                )
                                                .then(
                                                  (_) async =>
                                                      Navigator.pop(context),
                                                );
                                          } catch (e) {
                                            Fluttertoast.showToast(
                                              msg: e.toString(),
                                            );
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "NIK Sudah Digunakan");
                                        }
                                      }
                                    },
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldName(label) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: defaultPadding / 3,
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.grey.shade700),
      ),
    );
  }

  Widget dateField({controller, hintText}) {
    return SizedBox(
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
                tanggalLahir.text = DateFormat('dd-MM-yyyy').format(pickedDate);
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
            contentPadding:
                const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
              borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
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
    );
  }

  Widget nikField() {
    return SizedBox(
      height: 45,
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
          contentPadding:
              const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
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
            return "use valid nik";
          }
          return null;
        },
      ),
    );
  }

  Widget phoneField() {
    return SizedBox(
      height: 45,
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
          contentPadding:
              const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
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
            return "use valid phone number";
          }
          return null;
        },
      ),
    );
  }

  Widget emailField({controller, hintText}) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        onChanged: (value) => setState(() => email = value),
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey.shade700),
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
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
        controller: emailEditingController,
        validator: (value) {
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value!)) {
            return "Use valid email";
          }
          return null;
        },
      ),
    );
  }

  Widget nameField() {
    return SizedBox(
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
          contentPadding:
              const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
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
    );
  }

  Widget tempatLahirField() {
    return SizedBox(
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
          contentPadding:
              const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
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
    );
  }

  Widget alamatKTPField() {
    return SizedBox(
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
          contentPadding:
              const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
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
    );
  }

  Widget alamatDomisiliField() {
    return SizedBox(
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
          contentPadding:
              const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
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
    );
  }

  Widget genderField({assetIcon, hintText, item}) {
    return Container(
      height: 45,
      padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
          items: item.map<DropdownMenuItem<String>>(buildMenuItem).toList(),
          onChanged: (value) => setState(
            () => gender = value.toString(),
          ),
        ),
      ),
    );
  }

  Widget statusField({assetIcon, hintText, item}) {
    return Container(
      height: 45,
      padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
          items: item.map<DropdownMenuItem<String>>(buildMenuItem).toList(),
          onChanged: (value) => setState(
            () => status = value.toString(),
          ),
        ),
      ),
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
