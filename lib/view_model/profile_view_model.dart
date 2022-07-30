import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/model/profile/user_model.dart';
import 'package:vaccine_booking/view/profile/detail_screen.dart';
import 'package:vaccine_booking/view/profile/family_member_screen.dart';

import '../model/profile/api/user_api.dart';
import '../model/profile/family_model.dart';
import '../view/profile/change_password_screen.dart';

class ProfileViewModel extends ChangeNotifier {
  final familyApi = UserApi();
  List<FamilyModel> familyList = [];
  List<FamilyModel> userData = [];
  List<FamilyModel> userFamily = [];
  List<UserModel> usersProfile = [];
  List<UserModel> filterUserProfile = [];

  final itemsGender = ['laki_laki', 'perempuan'];
  final itemsStatus = ['ayah', 'ibu', 'anak', 'saudara'];
  final List itemsProfile = [
    'Profil Saya',
    'Anggota Keluarga',
    'Ubah Password',
    'Keluar Akun'
  ];
  final List iconsSvgDetailProfile = ['user', 'status', 'lock'];
  final List<Widget> wigetScreenDetailProfile = [
    const DetailScreen(),
    const FamilyMemberScreen(),
    const ChangePasswordScreen(),
  ];

  String name = '';
  String nik = '';
  String email = '';
  String phone = '';
  String dateBirth = '';
  String address = '';
  String idCardAddress = '';
  String placeBirth = '';
  String gender = '';
  String status = '';

  getAllFamilies() async {
    final getAllFamilies = await familyApi.getAllFamilies();
    familyList = getAllFamilies;
    notifyListeners();
  }

  getUsersProfile() async {
    final getProfiles = await familyApi.getUserProfile();
    usersProfile = getProfiles;
    notifyListeners();
  }

  addFamily({FamilyModel? family}) async {
    familyApi.addFamily(profile: family);
    notifyListeners();
  }

  editFamily(FamilyModel profile, int id) async {
    await familyApi.editUser(profile: profile, id: id);
  }

  editPassword({UserModel? user, int? id}) async {
    await familyApi.editPasswordUser(user: user, id: id);
  }

  deleteFamily({int? id}) async {
    familyApi.deleteFamily(id: id);
    notifyListeners();
  }

  filterUserData() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    filterUserProfile = usersProfile
        .where(
          (element) => element.username.contains(prefs.getString('nik')!),
        )
        .toList();
    notifyListeners();
  }

  filterUserFamily() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    if (userData.isNotEmpty && userId != null) {
      userFamily = familyList
          .where(
            (element) => element.profile!['user_id'] == userId,
          )
          .toList();
    }
    notifyListeners();
  }

  filterUser() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    final filterUser = familyList
        .where(
          (element) => element.nik!.contains(prefs.getString('nik')!),
        )
        .toList();
    userData = filterUser;
    if (filterUser.isEmpty) {
      dateBirth = 'Tanggal Lahir';
      name = 'Nama Lengkap Pemesan';
      nik = 'Nomor NIK';
      placeBirth = 'Tempat Lahir';
      email = 'Alamat Email';
      phone = 'No hp';
      idCardAddress = 'Alamat Berdasarkan KTP';
      address = 'Alamat Domisili';
      status = 'Status Keluarga';
      gender = 'Gender';
    } else {
      if (userData[0].dateBirth != null) {
        dateBirth = userData[0].dateBirth!;
      } else {
        dateBirth = 'Tanggal Lahir';
      }
      if (userData[0].name != null) {
        name = userData[0].name!;
      } else {
        name = 'Nama Lengkap Pemesan';
      }
      if (userData[0].nik != null) {
        nik = userData[0].nik!;
      } else {
        nik = 'Nomor NIK';
      }
      if (userData[0].placeBirth != null) {
        placeBirth = userData[0].placeBirth!;
      } else {
        placeBirth = 'Tempat Lahir';
      }
      if (userData[0].email != null) {
        email = userData[0].email!;
      } else {
        email = 'Alamat Email';
      }
      if (userData[0].phone != null) {
        phone = userData[0].phone!;
      } else {
        phone = 'No hp';
      }
      if (userData[0].idCardAddress != null) {
        idCardAddress = userData[0].idCardAddress!;
      } else {
        idCardAddress = 'Alamat Berdasarkan KTP';
      }
      if (userData[0].address != null) {
        address = userData[0].address!;
      } else {
        address = 'Alamat Domisili';
      }
      if (userData[0].statusFamily != null) {
        status = userData[0].statusFamily!.toLowerCase();
      } else {
        status = 'Status Keluarga';
      }
      if (userData[0].gender != null) {
        gender = userData[0].gender!.toLowerCase();
      } else {
        gender = 'Gender';
      }
    }

    if (filterUser.isNotEmpty) {
      prefs.setInt('userId', userData[0].profile!['user_id']);
    }

    notifyListeners();
  }

  detailProfile() async {
    if (userData.isEmpty) {
      dateBirth = 'Tanggal Lahir';
      name = 'Nama Lengkap Pemesan';
      nik = 'Nomor NIK';
      placeBirth = 'Tempat Lahir';
      email = 'Alamat Email';
      phone = 'No hp';
      idCardAddress = 'Alamat Berdasarkan KTP';
      address = 'Alamat Domisili';
      status = 'Status Keluarga';
      gender = 'Gender';
    } else {
      if (userData[0].dateBirth != null) {
        dateBirth = userData[0].dateBirth!;
      } else {
        dateBirth = 'Tanggal Lahir';
      }
      if (userData[0].name != null) {
        name = userData[0].name!;
      } else {
        name = 'Nama Lengkap Pemesan';
      }
      if (userData[0].nik != null) {
        nik = userData[0].nik!;
      } else {
        nik = 'Nomor NIK';
      }
      if (userData[0].placeBirth != null) {
        placeBirth = userData[0].placeBirth!;
      } else {
        placeBirth = 'Tempat Lahir';
      }
      if (userData[0].email != null) {
        email = userData[0].email!;
      } else {
        email = 'Alamat Email';
      }
      if (userData[0].phone != null) {
        phone = userData[0].phone!;
      } else {
        phone = 'No hp';
      }
      if (userData[0].idCardAddress != null) {
        idCardAddress = userData[0].idCardAddress!;
      } else {
        idCardAddress = 'Alamat Berdasarkan KTP';
      }
      if (userData[0].address != null) {
        address = userData[0].address!;
      } else {
        address = 'Alamat Domisili';
      }
      if (userData[0].statusFamily != null) {
        status = userData[0].statusFamily!.toLowerCase();
      } else {
        status = 'Status Keluarga';
      }
      if (userData[0].gender != null) {
        gender = userData[0].gender!.toLowerCase();
      } else {
        gender = 'Gender';
      }
    }
  }
}
