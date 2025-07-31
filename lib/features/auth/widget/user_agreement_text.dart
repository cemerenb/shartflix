import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

class UserAgreementText extends StatelessWidget {
  const UserAgreementText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                context.l10n.iReadAndAgree,
                style: context.textTheme.bodySmall,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  context.go('/terms');
                },
                child: Text(
                  context.l10n.userAgreement,
                  style: context.textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                context.l10n.pleaseReadUserAgreement,
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
