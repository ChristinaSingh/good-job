import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mobile_transfer_controller.dart';

class MobileTransferView extends GetView<MobileTransferController> {
  const MobileTransferView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MobileTransferView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MobileTransferView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
