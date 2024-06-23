import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget {
  final Function() onTapAdd;
  const EmptyState({super.key, required this.onTapAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 30.0.h),
        child: Column(
          children: [
            Lottie.asset('assets/animation/empty.json'),
            SizedBox(
              height: 10.0.h,
            ),
            const Text('No reminder'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: onTapAdd,
              child: const Text('Add reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
