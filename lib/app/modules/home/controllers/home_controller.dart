import 'package:epiq_fasha/app/data/model/response_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_book_new.dart';
import '../../../data/model/response_kategori.dart';
import '../../../data/model/response_popular_book.dart';
import '../../../data/provider/api_provider.dart';

class HomeController extends GetxController with StateMixin {

  final loadinglogin = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  var newBooks = RxList<DataBookNew>();
  var popularBooks = RxList<DataPopularBook>();
  var kategoriBuku = RxList<DataKategori>();
  var allBook = RxList<DataBook>();

  @override
  void onInit() {
    super.onInit();
    getDataBookNew();
    getDataKategori();
    getDataAllBook();
    getDataBookPopular();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataBookNew() async {
    change(null, status: RxStatus.loading());

    try {
      final responseNew = await ApiProvider.instance().get(Endpoint.bukuNew);

      if (responseNew.statusCode == 200 ) {
        final ResponseBookNew responseBukuNew = ResponseBookNew.fromJson(responseNew.data);

        if (responseBukuNew.data!.isEmpty ) {
          newBooks.clear();
          change(null, status: RxStatus.empty());
        } else {
          newBooks(responseBukuNew.data!);
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

  Future<void> getDataBookPopular() async {
    change(null, status: RxStatus.loading());

    try {
      final responsePopular = await ApiProvider.instance().get(Endpoint.bukuPopular);

      if (responsePopular.statusCode == 200) {
        final ResponsePopularBook responseBukuPopular = ResponsePopularBook.fromJson(responsePopular.data);

        if (responseBukuPopular.data!.isEmpty) {
          popularBooks.clear();
          change(null, status: RxStatus.empty());
        } else {
          popularBooks.assignAll(responseBukuPopular.data!);
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

  Future<void> getDataKategori() async {
    change(null, status: RxStatus.loading());

    try {
      final responseKategori = await ApiProvider.instance().get(Endpoint.kategoriBuku);
      if (responseKategori.statusCode == 200) {
        final ResponseKategori responseKategoriBuku = ResponseKategori.fromJson(responseKategori.data);

        if ( responseKategoriBuku.data!.isEmpty) {
          popularBooks.clear();
          change(null, status: RxStatus.empty());
        } else {
          kategoriBuku.assignAll(responseKategoriBuku.data!);
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

  Future<void> getDataAllBook() async {
    allBook.clear();
    change(null, status: RxStatus.loading());

    try {
      final responseBook = await ApiProvider.instance().get(Endpoint.buku);

      if (responseBook.statusCode == 200) {

        final ResponseBook responseAllBook = ResponseBook.fromJson(responseBook.data);

        if (responseAllBook.data!.isEmpty) {
          allBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          allBook.assignAll(responseAllBook.data!);
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
}
