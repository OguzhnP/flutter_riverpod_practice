// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoadingWidget extends StatelessWidget {
  bool? isLoading;
  Widget child;
  LoadingWidget({
    Key? key,
    this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      );
    } else if (isLoading == false) {
      return const Center(
        child: Text("Bir sorun oluştu, tekrar deneyin"),
      );
    } else {
      return child;
    }
  }
}
