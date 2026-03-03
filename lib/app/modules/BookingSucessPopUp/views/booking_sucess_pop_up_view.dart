import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/booking_sucess_pop_up_controller.dart';

class BookingSucessPopUpView extends GetView<BookingSucessPopUpController> {
  const BookingSucessPopUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Get.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Success Icon
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.teal,
                size: 100,
              ),
              const SizedBox(height: 24),

              // Success Title
              Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Confirmation Message
              const Text(
                'Your service request has been successfully submitted.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // --- Next Steps Section (Informational Cards) ---
              _buildInfoCard(
                icon: Icons.chat_bubble_outline,
                title: 'Next Step: Provider Chat',
                description:
                    'A nearby service provider will soon review your request and initiate a chat with you to discuss the details.',
                color: Colors.blue.shade100,
              ),
              const SizedBox(height: 20),

              _buildInfoCard(
                icon: Icons.money_outlined,
                title: 'Discuss Work & Price',
                description:
                    'Use the chat feature to discuss work specifics and agree upon a final price with the provider.',
                color: Colors.amber.shade100,
              ),
              const SizedBox(height: 20),

              _buildInfoCard(
                icon: Icons.payment,
                title: 'Payment Policy',
                description:
                    'You will only need to pay the agreed amount once the service provider accepts the price, either before service begins or after its completion.',
                color: Colors.green.shade100,
              ),
              const SizedBox(height: 50),

              // Action Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to home or the main dashboard
                    controller.navigateToHome();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'GO TO DASHBOARD',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build the informative cards
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.teal.shade800),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.teal.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
