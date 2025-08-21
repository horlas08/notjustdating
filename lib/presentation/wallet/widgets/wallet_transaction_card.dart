

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/transaction/models/wallet_transaction_model.dart';
import '../../core/font.dart';

class WalletTransactionCard extends StatelessWidget {
  const WalletTransactionCard({
    super.key,
    required this.walletTrnx,
  });

  final WalletTransactionModel walletTrnx;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(walletTrnx.narration ?? "N/A",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              Text(walletTrnx.create_at ?? "N/A",
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))
            ],
          ),
          Row(
            children: [
              Text("${walletTrnx.amount} Crdt",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: Font.inter,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
              SizedBox(
                width: 10.w,
              ),
              walletTrnx.type == "credit"
                  ? Image.asset("assets/images/pngs/credit.png")
                  : Image.asset("assets/images/pngs/debit.png")
            ],
          )
        ],
      ),
    );
  }
}