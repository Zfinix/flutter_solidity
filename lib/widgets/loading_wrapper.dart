import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_solidity/core/extensions/extensions.dart';
import 'package:flutter_solidity/core/providers.dart';
import 'package:flutter_solidity/utils/colors.dart';

import 'package:flutter_solidity/widgets/animated_logo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadingWrapper extends HookConsumerWidget {
  const LoadingWrapper({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context, ref) {
    final vm = ref.watch(loaderVM);
    return Container(
      child: vm.isLoading
          ? Stack(
              children: [
                child!,
                AbsorbPointer(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: black.withOpacity(0.75),
                    child: Center(
                      child: vm.percent == null
                          ? const FlSolidityAnimatedLogo()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FlSolidityAnimatedLogo(animate: false),
                                const Gap(40),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    height: 9,
                                    width: context.screenWidth(0.55),
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.white12,
                                      value: vm.percent ?? 0,
                                      valueColor:
                                          const AlwaysStoppedAnimation(white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                )
              ],
            )
          : child,
    );
  }
}
