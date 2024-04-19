import 'package:epiq_fasha/components/customUpdateProfile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/updateprofile_controller.dart';

class UpdateprofileView extends GetView<UpdateprofileController> {
  const UpdateprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        flexibleSpace: const SizedBox
          (
          width: 100,
        ),
        toolbarHeight: 50,
        title: Text(
          'Update Profile',
          style: GoogleFonts.montserrat(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leadingWidth: 55,
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10)
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await controller.getDataUser();
        },
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(
                  height: 10,
                ),

                sectionForm(width)
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget sectionForm(double width){
    return Obx((){
      var dataUser = controller.detailProfile.value;

      if(controller.detailProfile.value == null){
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF41B54A)),
          ),
        ),
      );
    }
    else{
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            Column(
              children: [
                Stack(
                  children: [
                    // Profile Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'lib/assets/images/profile.png',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    // Button Overlay
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Handle button tap (e.g., open image picker)
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF5F5F5),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),

                Column(
                  children: [
                    Text(
                      dataUser!.username.toString(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    Text(
                      '${dataUser.email.toString()}|${ dataUser.telepon.toString()}',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    )
                  ],
                )
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            Form(
              key: controller.formKey,
              child: Column(
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldUpdateProfile(
                            obsureText: false,
                            controller: controller.namalengkapController,
                            labelText: "Nama Lengkap"),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: CustomTextFieldUpdateProfile(
                            obsureText: false,
                            controller: controller.usernameController,
                            labelText: "Username"),
                      ),
                    ],
                  ),

                  CustomTextFieldUpdateProfile(
                      obsureText: false,
                      controller: controller.emailController,
                      labelText: "Email"),

                  CustomTextFieldUpdateProfile(
                      obsureText: false,
                      controller: controller.bioController,
                      labelText: "Bio"),

                  CustomTextFieldUpdateProfile(
                      obsureText: false,
                      controller: controller.teleponController,
                      labelText: "Nomor Telepon"),

                  const SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    width: width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: ()=> controller.updateProfilePost(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF41B54A),
                      ),
                      child: Obx(() => controller.loading.value?
                      const CircularProgressIndicator(
                        color: Colors.white,
                      ): Text(
                        "Update Profile",
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    });
  }
}
