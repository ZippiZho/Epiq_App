import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/customUcapan.dart';
import '../../../data/constant/endpoint.dart';
import '../../../data/model/user/response_login.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {

  final loadinglogin = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    String? status = StorageProvider.read(StorageKey.status);

    if (status == "logged") {
      _showMyDialog(
              (){
                Get.offAllNamed(Routes.DASHBOARD);
          },
          "Pemberitahuan",
          "Anda sudah login",
          "Ok"
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  login() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,
            data: dio.FormData.fromMap(
                {
                  "email": emailController.text.toString(),
                  "password": passwordController.text.toString()
                }
            )
        );
        if (response.statusCode == 200) {
          ResponseLogin responseLogin = ResponseLogin.fromJson(response.data);
          await StorageProvider.write(StorageKey.status, "logged");
          await StorageProvider.write(StorageKey.username, responseLogin.data!.username.toString());
          await StorageProvider.write(StorageKey.tokenUser, responseLogin.data!.token.toString());
          await StorageProvider.write(StorageKey.idUser, responseLogin.data!.id.toString());
          await StorageProvider.write(StorageKey.email, responseLogin.data!.email.toString());
          await StorageProvider.write(StorageKey.bio, responseLogin.data!.bio.toString());
          await StorageProvider.write(StorageKey.namaLengkap, responseLogin.data!.namaLengkap.toString());
          await StorageProvider.write(StorageKey.telepon, responseLogin.data!.telepon.toString());

          Get.offAll(const CustomUcapan());
        } else {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "Login Gagal, Coba kembali masuk dengan akun anda",
              "Ok"
          );
        }
      }
      loadinglogin(false);
    } on dio.DioException catch (e) {
      loadinglogin(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "${e.response?.data['message']}",
              "Ok"
          );
        }
      } else {
        _showMyDialog(
              (){
            Navigator.pop(Get.context!, 'OK');
          },
          "Kesalahaan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loadinglogin(false);
      _showMyDialog(
            (){
          Navigator.pop(Get.context!, 'OK');
        },
        "Error",
        e.toString(),
        "OK",
      );
    }
  }

  Future<void> _showMyDialog(final onPressed, String judul, String deskripsi, String nameButton) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF5F5F5),
          title: Text(
            'EpiQ! App',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: const Color(0xFF41B54A),
            ),
          ),

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const SizedBox(
                  height: 1,
                  child: ColoredBox(
                    color: Color(0xFFE5DADA),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  judul,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 14.0
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  deskripsi,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: -0.2,
                      fontSize: 16.0
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: double.infinity,
              child: TextButton(
                autofocus: true,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF41B54A),
                  animationDuration: const  Duration(milliseconds: 300),
                ),
                onPressed: onPressed,
                child: Text(
                  nameButton,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
