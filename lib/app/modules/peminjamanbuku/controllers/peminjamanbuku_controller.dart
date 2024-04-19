import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_detail_buku.dart';
import '../../../data/model/peminjaman/response_peminjaman.dart';
import '../../../data/provider/api_provider.dart';
import '../../../routes/app_pages.dart';

class PeminjamanbukuController extends GetxController with StateMixin{

  var dataDetailBook = Rxn<DataDetailBuku>();
  final id = Get.parameters['id'];

  var loading = false.obs;

  late String formattedToday;
  late String formattedTwoWeeksLater;

  // CheckBox
  var isChecked = false.obs;

  void toggleCheckBox() {
    isChecked.value = !isChecked.value;
  }

  // Data Peminjaman
  late String statusDataPeminjaman;

  @override
  void onInit() {
    super.onInit();
    getDataDetailBuku(id);

    // Get Tanggal hari ini
    DateTime todayDay = DateTime.now();

    // Menambahkan 14 hari ke tanggal hari ini
    DateTime twoWeeksLater = todayDay.add(const Duration(days: 14));

    // Format tanggal menjadi string menggunakan intl package
    formattedToday = DateFormat('yyyy-MM-dd').format(todayDay);
    formattedTwoWeeksLater = DateFormat('yyyy-MM-dd').format(twoWeeksLater);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataDetailBuku(String? idBuku) async {
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(
          '${Endpoint.detailBuku}/$idBuku');

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDetailBuku responseBuku = ResponseDetailBuku.fromJson(responseDetailBuku.data);

        if (responseBuku.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          dataDetailBook(responseBuku.data);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  addPeminjamanBuku() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var bukuID = id.toString();

      var responsePostPeminjaman = await ApiProvider.instance().post(Endpoint.pinjamBuku,
        data: {
          "BukuID": bukuID,
        },
      );

      if (responsePostPeminjaman.statusCode == 201) {
        ResponsePeminjaman responsePeminjaman = ResponsePeminjaman.fromJson(responsePostPeminjaman.data!);
        String judulBuku = Get.parameters['judul'].toString();
        String peminjamanID = responsePeminjaman.data!.peminjamanID.toString();

        _showMyDialog(
              () {
            Get.offAllNamed(Routes.BUKTIPEMINJAMAN, parameters: {
              'idPeminjaman': peminjamanID,
              'asalHalaman' : 'detailBuku',
            });
            getDataDetailBuku(bukuID);
          },
          "Peminjaman Berhasil",
          "Buku $judulBuku berhasil dipinjam",
          "Oke",
        );
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          "Buku gagal dipinjam, silakan coba kembali",
          "Ok",
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                () {
              Navigator.pop(Get.context!, 'OK');
            },
            "Pemberitahuan",
            "${e.response?.data?['message']}",
            "Ok",
          );
        }
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loading(false);
      _showMyDialog(
            () {
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
