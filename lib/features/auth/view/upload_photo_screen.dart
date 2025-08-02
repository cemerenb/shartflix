import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shartflix/features/auth/view_model/auth_bloc.dart';
import 'package:shartflix/features/auth/view_model/auth_event.dart';
import 'package:shartflix/features/auth/view_model/auth_state.dart';
import 'package:shartflix/features/auth/widget/image_picker_sheet.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/snackbars/snackbars.dart';
import 'package:shartflix/widgets/custom_app_bar.dart';
import 'package:shartflix/widgets/custom_container.dart';
import 'package:shartflix/widgets/custom_elevated_button.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  File? _selectedImage;
  final ImagePicker picker = ImagePicker();
  bool _isUploading = false;
  bool _initialHasPhoto = false;

  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      final hasPhoto = authState.user.photoUrl?.isNotEmpty == true;

      _initialHasPhoto = hasPhoto;
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen önce bir fotoğraf seçin')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    context.read<AuthBloc>().add(
      AuthUploadProfileImageRequested(imageFile: _selectedImage!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated && _isUploading) {
          setState(() {
            _isUploading = false;
          });

          CustomSnackbar.successSnackbar(
            context: context,
            message: context.l10n.photoUploadSuccess,
          );

          context.read<AuthBloc>().add(AuthCheckRequested());

          if (_initialHasPhoto) {
            context.pop();
          } else {
            context.go('/home');
          }
        }

        if (state is AuthImageUploadError) {
          setState(() {
            _isUploading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }

        if (state is AuthImageUploadError) {
          setState(() {
            _isUploading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthImageUploading;

        return Scaffold(
          appBar: CustomAppBar(
            title: context.l10n.profileDetail,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          body: SizedBox(
            height: context.screenHeight,
            width: context.screenWidth,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        context.l10n.uploadPhoto,
                        style: context.textTheme.headlineSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60.0,
                          vertical: 20,
                        ),
                        child: Text(
                          context.l10n.profileLoremIpsum,
                          style: context.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showImagePickerBottomSheet(context, picker, (
                            File image,
                          ) {
                            setState(() {
                              _selectedImage = image;
                            });
                          });
                        },
                        child: CustomContainer(
                          height: context.screenWidth * 0.45,
                          width: context.screenWidth * 0.45,
                          borderRadius: BorderRadius.circular(40),
                          child: _selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(32),
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child: Image.asset('assets/icon/add.png'),
                                ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: CustomElevatedButton(
                      isLoading: isLoading,
                      onPressed: isLoading ? null : _uploadImage,
                      child: Text(
                        context.l10n.continueText,
                        style: context.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
