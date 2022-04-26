import 'package:flutter/material.dart';

customError() {
  return ErrorWidget.builder = ((details) {
    return Material(
      child: Container(
        color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Please check the enter data')],
        ),
      ),
    );
  });
}
