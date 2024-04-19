import 'package:epiq_fasha/app/data/model/buku/response_all_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class SearchbookController extends GetxController with StateMixin{

  var searchBook = RxList<DataBook>();


  final TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getDataAllBuku();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Get Data Buku
  Future<void> getDataAllBuku() async {
    searchBook.clear();
    change(null, status: RxStatus.loading());

    try {
      final keyword = searchController.text.toString();
      final responseSemuaBook;

      if(keyword == ''){
        responseSemuaBook = await ApiProvider.instance().get('${Endpoint.searchBook}all/buku/null');
      }else{
        responseSemuaBook = await ApiProvider.instance().get('${Endpoint.searchBook}all/buku/$keyword');
      }

      if (responseSemuaBook.statusCode == 200) {
        final ResponseAllBook responseBook = ResponseAllBook.fromJson(responseSemuaBook.data!);

        if (responseBook.data!.isEmpty) {
          searchBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          searchBook(responseBook.data!);
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
