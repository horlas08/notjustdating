import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ofwhich_v2/injectable.dart';
import 'package:ofwhich_v2/presentation/routes/app_router.gr.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../domain/user_service/model/date_payment_details.dart';
import '../routes/app_router.dart';

@RoutePage()
class DatePaymentWebViewPage extends StatefulWidget {
  final DatePaymentData paymentData;
  final String paymentInitiatorType; // 'requested' or 'requester'

  const DatePaymentWebViewPage({
    super.key,
    required this.paymentData,
    required this.paymentInitiatorType,
  });

  @override
  State<DatePaymentWebViewPage> createState() => _DatePaymentWebViewPageState();
}

class _DatePaymentWebViewPageState extends State<DatePaymentWebViewPage> {
  late final WebViewController _controller;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    final String paymentUrl = _buildPaymentUrl();
    const PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params)

      // _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            // getIt<AppRouter>().replace(PaymentSuccessPage(
            //     paymentInitiatorType: widget.paymentInitiatorType,
            //     transactionReference: widget.paymentData.reference_id,
            //     amount: widget.paymentData.amount.toString()));
          },
          onUrlChange: (t) {
            if (t.url != null &&
                t.url!.contains("/web/payment/successful/confirm")) {
              getIt<AppRouter>().replace(PaymentSuccessPage(
                  paymentInitiatorType: widget.paymentInitiatorType,
                  transactionReference: widget.paymentData.reference_id,
                  amount: widget.paymentData.amount.toString()));
            }
          },
        
          onWebResourceError: (WebResourceError error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Error loading payment page: ${error.description}'),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(paymentUrl));
  }

  String _buildPaymentUrl() {
    const baseUrl = 'https://njd.findartisansnigeria.com/web/payment/store';
    final queryParams = {
      'name': widget.paymentData.name,
      'email': widget.paymentData.email,
      'amount': widget.paymentData.amount.toString(),
      'reference_id': widget.paymentData.reference_id,
      'payment_initiator_type': widget.paymentInitiatorType,
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    log(uri.toString());
    return uri.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  
}

// Usage example:
/*
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => DatePaymentWebViewPage(
      paymentData: DatePaymentData(
        reference_id: '05E961767770376',
        name: 'Anifowoshe Fatimah',
        email: 'fatimah.anifowoshe@gmail.com',
        amount: 5000,
      ),
      paymentInitiatorType: 'requested',
    ),
  ),
);
*/
