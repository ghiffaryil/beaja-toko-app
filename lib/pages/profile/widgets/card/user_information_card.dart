// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:beaja_toko/bloc/profile/get_user_details/get_user_details_bloc.dart';
import 'package:beaja_toko/bloc/profile/update_image_user_details/update_image_user_details_bloc.dart';
import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/constants/function/show_toast.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/images.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/models/profile/update_user_details/update_image_user_details_request_model.dart';
import 'package:beaja_toko/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserInformationCard extends StatefulWidget {
  final int userId;

  const UserInformationCard({super.key, required this.userId});

  @override
  State<UserInformationCard> createState() => _UserInformationCardState();
}

class _UserInformationCardState extends State<UserInformationCard> {
  XFile? profileImage;
  String profileImageSelected = '';
  final ImagePicker picker = ImagePicker();
  String userId = '';

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() {
    context
        .read<GetUserDetailsBloc>()
        .add(const GetUserDetailsEvent.getUserDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: CustomPadding.p2,
      child: BlocBuilder<GetUserDetailsBloc, GetUserDetailsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return Container();
            },
            loading: () {
              return Container(
                padding: CustomPadding.p3,
                child: const CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            },
            loaded: (data) {
              return Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: data.userDetail.isNotEmpty
                                  ? Image.network(
                                      data.userDetail.first.image,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      Images.userEmpty,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              _selectImageFromGallery();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                color: Colors.black.withOpacity(0.5),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: AppColors.bgLight))),
                              child: Text(
                                data.userDetail.isNotEmpty
                                    ? '${data.userDetail.first.namaDepan} ${data.userDetail.first.namaTengah} ${data.userDetail.first.namaBelakang}'
                                    : '-',
                                style:
                                    TextStyles.h4(color: AppColors.secondary),
                              )),
                          CustomDividers.verySmallDivider(),
                          Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: AppColors.bgLight))),
                              child: Text(data.email)),
                          CustomDividers.verySmallDivider(),
                          Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: AppColors.bgLight))),
                              child: Text(data.userDetail.isNotEmpty
                                  ? data.userDetail.first.phone
                                  : '')),
                          CustomDividers.verySmallDivider(),
                          Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: AppColors.bgLight))),
                              child: Text(data.userDetail.isNotEmpty
                                  ? data.userDetail.first.alamatLengkap
                                  : '')),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _selectImageFromGallery() async {
    print('Pick Image');
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        print('Image Selected = ${pickedImage.path}');
        profileImage = pickedImage;
        profileImageSelected = pickedImage.name.toString();
      });

      // Do Update Image
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return showModalConfirmationUpdateImage();
        },
        barrierDismissible: false,
      );
    }
  }

  Widget showModalConfirmationUpdateImage() {
    return BlocListener<UpdateImageUserDetailsBloc,
        UpdateImageUserDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const ProfilePage();
              }));
            },
            error: (msg) {
              showToast(message: msg);
              Navigator.pop(context);
            });
      },
      child:
          BlocBuilder<UpdateImageUserDetailsBloc, UpdateImageUserDetailsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return AlertDialog(
                surfaceTintColor: AppColors.white,
                title: Text(
                  'Perhatian! Gambar akan diubah?',
                  style: TextStyles.h4(color: AppColors.bg),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ButtonOutlined.primary(
                          onPressed: () {
                            return Navigator.pop(context);
                          },
                          text: 'Batal',
                          fontSize: 15,
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ButtonFilled.primary(
                            text: 'OK',
                            height: 30,
                            fontSize: 15,
                            onPressed: () {
                              final requestModel =
                                  UpdateImageUserDetailsRequestModel(
                                image: profileImage,
                              );
                              context.read<UpdateImageUserDetailsBloc>().add(
                                  UpdateImageUserDetailsEvent.updateImage(
                                      requestModel, widget.userId));
                            }),
                      ),
                    ],
                  ),
                ],
              );
            },
            loading: () {
              return AlertDialog(
                surfaceTintColor: AppColors.white,
                content: SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomDividers.smallDivider(),
                        const CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                        CustomDividers.smallDivider(),
                        const Text('Uploading Image ...'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
