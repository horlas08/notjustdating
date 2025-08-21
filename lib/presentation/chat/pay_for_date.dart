// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ofwhich_v2/domain/user_service/model/date_request_model.dart';
import 'package:ofwhich_v2/presentation/general_widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../application/chat_view_model/chat_view_model.dart';
import '../../domain/user_service/model/date_model.dart';
import '../general_widgets/widgets.dart';
// import 'package:flutter/services.dart';

@RoutePage()
class PayForDateScreen extends StatefulWidget {
  final List<num>? locations;
  final String? budget;
  final List<DateModel>? dates;
  final String? paymentMethod;
  final num? dateUserId;
  final num? dateId;
  final String? type;

  const PayForDateScreen(
      {Key? key,
      this.locations,
      this.budget,
      this.dates,
      this.paymentMethod,
      this.dateId,
      this.type,
      this.dateUserId})
      : super(key: key);

  @override
  _PayForDateScreenState createState() => _PayForDateScreenState();
}

class _PayForDateScreenState extends State<PayForDateScreen>
    with SingleTickerProviderStateMixin {
  String selectedPayment = 'wallet';
  bool isProcessing = false;

  Future<void> handlePayment() async {
    setState(() {
      isProcessing = true;
    });

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isProcessing = false;
    });

    // Navigate to success screen
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFDF2F8),
                Color(0xFFFCE7F3),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                const PaymentHeader(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),

                        // Amount Card
                        const PremiumAmountCard(),

                        SizedBox(height: 24.h),

                        // Payment Methods
                        Text(
                          'Payment Method',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Wallet Option
                        PaymentMethodCard(
                          value: 'wallet',
                          icon: Icons.account_balance_wallet,
                          title: 'Wallet Balance',
                          subtitle: '\$24.50 available',
                          isSelected: selectedPayment == 'wallet',
                          onTap: () {
                            setState(() {
                              selectedPayment = 'wallet';
                            });
                          },
                        ),
                        SizedBox(height: 12.h),
                        // Card Option
                        PaymentMethodCard(
                          value: 'card',
                          icon: Icons.credit_card,
                          title: 'Card',
                          subtitle: '**** **** **** 1234',
                          isSelected: selectedPayment == 'card',
                          onTap: () {
                            setState(() {
                              selectedPayment = 'card';
                            });
                          },
                        ),

                        SizedBox(height: 12.h),
                        // Payment Button
                        PaymentButton(
                          isProcessing: isProcessing,
                          onPressed: isProcessing
                              ? null
                              : () {
                                  model.planDate(
                                      type: widget.type,
                                      locations: widget.locations,
                                      payment_method: selectedPayment,
                                      budget: widget.budget,
                                      dateUserId: widget.dateUserId,
                                      dateId: widget.dateId,
                                      dates: widget.dates);
                                },
                        ),

                        SizedBox(height: 16.h),

                        // Security Note
                        SecurityNote(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
