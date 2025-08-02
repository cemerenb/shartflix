import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/auth/view_model/auth_state.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';
import 'package:shartflix/widgets/custom_elevated_button.dart';

class ProfileArea extends StatelessWidget {
  final AuthAuthenticated state;
  const ProfileArea({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child:
                      state.user.photoUrl != null &&
                          state.user.photoUrl!.isNotEmpty
                      ? Image.network(
                          state.user.photoUrl!,
                          fit: BoxFit.fill,
                          width: 70,
                          height: 70,
                        )
                      : Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.person, size: 40),
                        ),
                ),
                Spacers.horizontalMedium,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.name,
                        style: context.textTheme.titleMedium,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      Text(
                        "ID: ${state.user.id}",
                        style: context.textTheme.labelMedium,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 40,
                child: CustomElevatedButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  borderRadius: 10,
                  height: 50,
                  onPressed: () {
                    GoRouter.of(context).push('/upload-photo');
                  },
                  child: Text(context.l10n.uploadPhoto),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
