import 'package:flutter/material.dart';

void erro(dynamic context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red.shade900,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

void sucesso(dynamic context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green.shade900,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}