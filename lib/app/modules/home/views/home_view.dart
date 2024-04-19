import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_images/carousel_images.dart';
import 'package:epiq_fasha/app/data/model/response_book.dart';
import 'package:epiq_fasha/app/data/provider/storage_provider.dart';
import 'package:epiq_fasha/components/customImageCarousel.dart';
import 'package:epiq_fasha/components/customSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double toolbarHeight = MediaQuery.of(context).padding.top;
    double bodyHeight = height - toolbarHeight;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: Scaffold(
        body: SizedBox(
          width: width,
          height: bodyHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(
                  height: 10.h,
                ),

                sectionUser(),

                SizedBox(
                  height: 10.h,
                ),

                const CustomImageCarousel(),

                SizedBox(
                  height: 20.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomSearchBar(
                      controller: controller.searchController,
                      onFocus: false,
                      preficIcon: const Icon(Icons.search_rounded),
                      onChanged: (value){
                        Get.toNamed(Routes.SEARCHBOOK);
                      },
                      hinText: "Search a Book Name",
                  ),
                ),

                SizedBox(
                  height: 20.h,
                ),

                Obx(() => controller.kategoriBuku.isEmpty ?
                shimmersectionKategoriBook() : sectionKategoriBook(),
                ),


                SizedBox(
                  height: 20.h,
                ),

                Obx(() => controller.newBooks.isEmpty ?
                shimmerSectionTrendingBook() : sectionTrendingBook(),
                ),

                SizedBox(
                  height: 20.h,
                ),

                Obx(() => controller.popularBooks.isEmpty ?
                    shimmerSectionPopularBook() : sectionPopularBook(),
                ),

                SizedBox(
                  height: 20.h,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: sectionImage(),
                ),

                SizedBox(
                  height: 20.h,
                ),

                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'New Arrivals',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                           'View All',
                           style: GoogleFonts.montserrat(
                             color: Colors.black,
                             fontSize: 18,
                             fontWeight: FontWeight.w600,
                           ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Obx(() => controller.allBook.isEmpty ?
                    shimmerAllBook() : sectionAllBook(),
                    ),
                  ],
                ),

                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget sectionUser(){
    // Color
    const Color primary = Color(0xFF41B54A);

    // Get username di storage provider
    String usernameUser = StorageProvider.read(StorageKey.username);

    // Ucapan selamat
    var jam = DateTime.now().hour;

    String ucapan;

    if(jam >= 1 && jam <= 11){
      ucapan = "Good Mooring";
    }else if(jam >= 11 && jam < 15){
      ucapan = "Good Afternoon";
    }else if(jam >= 15 && jam < 18){
      ucapan = "Good Afternoon☀️";
    }else {
      ucapan = "Good Evening🌙";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'lib/assets/images/profile.png',
                  width: 35.w,
                  height: 35.w,
                ),
              ),

              SizedBox(
                width: 13.w,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText.rich(
                    TextSpan(
                      text: "Hallo ",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp,
                        color: Colors.black, // Color for the fixed text
                      ),
                      children: [
                        TextSpan(
                          text: usernameUser,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w800,
                            fontSize: 14.sp,
                            color: primary, // Color for the username
                          ),
                        ),
                      ],
                    ),
                  ),

                  AutoSizeText(
                    ucapan,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: Colors.grey, // C
                    ),
                  )
                ],
              ),
            ],
          ),

          IconButton(
            onPressed: () {
              // Tindakan yang diambil saat tombol di tekan
            },
            icon: SvgPicture.asset(
              "lib/assets/logo/bell.svg",
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionImageSlider(){
    final List<String> listImages = [
      'lib/assets/slider/slider1.png',
      'lib/assets/slider/slider2.png',
      'lib/assets/slider/slider1.png',
      'lib/assets/slider/slider2.png',
    ];

    return CarouselImages(
      scaleFactor: 0.9,
      listImages: listImages,
      height: 250,
      borderRadius: 10.w,
      cachedNetworkImage: true,
      verticalAlignment: Alignment.topCenter,
      onTap: (index){
      },
    );
  }

  Widget sectionPopularBook() {
    final width = MediaQuery.of(Get.context!).size.width;
    final widthContainer = width - 40.0;
    return SizedBox(
      height: 210,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.popularBooks.map((buku) {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.DETAILBOOK,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul!).toString()
                  },
                );
              },
              child: SizedBox(
                height: 180,
                width: MediaQuery.of(Get.context!).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      // Container dengan latar hitam dan konten buku
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 150,
                          width: widthContainer,
                          padding: const EdgeInsets.only(left: 135,top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF383838),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  buku.judul!,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Penulis : ${buku.penulis!}",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  buku.deskripsi!,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Gambar di sebelah kiri (overlay)
                      Positioned(
                        left: 10,
                        top: 0,
                        bottom: 10,
                        child: Container(
                          width: 130,
                          height: 180,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.30), // Ubah nilai opacity sesuai kebutuhan
                                    BlendMode.darken,
                                  ),
                                  child: Image.network(
                                    buku.coverBuku.toString(),
                                    width: 130,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 5,
                                left: 5,
                                right: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.fire_hydrant_alt_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),

                                      const SizedBox(
                                        width: 3,
                                      ),

                                      Expanded(
                                        child: Text(
                                          'Popular Book',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget shimmerSectionPopularBook() {
    final width = MediaQuery.of(Get.context!).size.width;
    final widthContainer = width - 40.0;
    return SizedBox(
      height: 225,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              height: 180,
              width: MediaQuery.of(Get.context!).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Stack(
                    children: [
                      // Container dengan latar hitam dan konten buku (placeholder)
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 150,
                          width: widthContainer,
                          padding: const EdgeInsets.only(left: 135, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200,
                                  height: 20,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 150,
                                  height: 15,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 200,
                                  height: 12,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 200,
                                  height: 12,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Gambar di sebelah kiri (overlay)
                      Positioned(
                        left: 10,
                        top: 0,
                        bottom: 10,
                        child: Container(
                          width: 130,
                          height: 180,
                          decoration: const BoxDecoration(
                            color: Colors.white
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 130,
                              height: 180,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionKategoriBook(){
    return SizedBox(
      height: MediaQuery.of(Get.context!).size.height * 0.050,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.kategoriBuku.length,
          itemBuilder: (context, index) {
            var buku = controller.kategoriBuku[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                width: 100,
                height: 50,
                child: TextButton(
                    onPressed: (){
                      Get.toNamed(Routes.BOOKBYKATEGORI,
                        parameters: {
                          'idKategori': (buku.kategoriID ?? 0).toString(),
                          'namaKategori': (buku.namaKategori!).toString()
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0XFFF5F5F5)
                    ),
                    child: Text(
                      buku.namaKategori!,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    )
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget shimmersectionKategoriBook(){

    int itemCount = 4;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: MediaQuery.of(Get.context!).size.height * 0.050,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: Text(
                    'Kategori Buku',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  )
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget sectionTrendingBook() {
    return SizedBox(
        height: 205,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.newBooks.asMap().entries.map((entry) {
              final index = entry.key;
              final buku = entry.value;
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.DETAILBOOK,
                    parameters: {
                      'id': (buku.bukuID ?? 0).toString(),
                      'judul': (buku.judulBuku!).toString()
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 20 : 0,
                    right: index < controller.newBooks.length - 1 ? 10 : 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 135,
                            height: 205,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.30), // Ubah nilai opacity sesuai kebutuhan
                                  BlendMode.darken,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 4 / 6,
                                  child: Image.network(
                                    buku.coverBuku.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 10,
                            left: 5,
                            right: 5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.thumb_up,
                                    color: Colors.white,
                                    size: 16,
                                  ),

                                  const SizedBox(
                                    width: 3,
                                  ),

                                  Expanded(
                                    child: Text(
                                      'Recommended',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        )
    );
  }

  Widget shimmerSectionTrendingBook() {
    return SizedBox(
      height: 205,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 20 : 0,
              right: index < 3 ? 10 : 20,
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 135,
                        height: 205,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 5,
                        right: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.thumb_up,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                child: FittedBox(
                                  child: Text(
                                    'Recommended',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget sectionAllBook() {
    return Obx((){
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.allBook.length,
        itemBuilder: (context, index) {
          var bukuList = controller.allBook[index].dataBuku;

          if (index == 1) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bukuList?.length,
                itemBuilder: (context, index) {
                  DataBuku buku = bukuList![index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.DETAILBOOK,
                        parameters: {
                          'id': (buku.bukuID ?? 0).toString(),
                          'judul': (buku.judul!).toString()
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 135,
                                height: 175,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.40), // Ubah nilai opacity sesuai kebutuhan
                                      BlendMode.darken,
                                    ),
                                    child: Image.network(
                                      buku.coverBuku.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 5,
                                left: 5,
                                right: 0,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.new_label,
                                      color: Colors.white,
                                      size: 18,
                                    ),

                                    Text(
                                      'Book New',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.3,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  buku.judul!,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                Text(
                                  buku.penulis!,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: const Color(0xFF41B54A),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                Text(
                                  buku.deskripsi!,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.4,
                                    color: Colors.black.withOpacity(0.70),
                                  ),
                                  maxLines: 4,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink(); // Jika bukan kategori pertama, kembalikan widget kosong
          }
        },
      );
    });
  }

  Widget shimmerAllBook() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3, // Menampilkan 3 item
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 135,
                    height: 175,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 24,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.infinity,
                          height: 64,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget sectionImage(){
    // Size
    double width = MediaQuery.of(Get.context!).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width,
        height: 115,
        decoration: BoxDecoration(
          image:  DecorationImage(
              image: const AssetImage(
                'lib/assets/slider/slider1.png',
              ),
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.30), // Ubah nilai opacity sesuai kebutuhan
                BlendMode.darken,
              ),
              fit: BoxFit.cover
          ),
        ),



        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Temukan Ribuan Buku',
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 26.0
                      ),
                    ),
                    Text(
                      'Dengan sekali klik',
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14.0
                      ),
                    )
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.navigate_next_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
