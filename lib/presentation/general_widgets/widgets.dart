import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentHeader extends StatelessWidget {
  const PaymentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.grey[600]),
          ),
          Expanded(
            child: Text(
              'Payment',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
          SizedBox(width: 48.w),
        ],
      ),
    );
  }
}

class PremiumAmountCard extends StatelessWidget {
  const PremiumAmountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const PremiumHeader(),
          SizedBox(height: 12.h),
          const PremiumPrice(),
          // SizedBox(height: 8.h),
          // PremiumDuration(),
          SizedBox(height: 16.h),
          // PremiumFeaturesList(),
        ],
      ),
    );
  }
}

class PremiumHeader extends StatelessWidget {
  const PremiumHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.favorite,
          color: Colors.pink,
          size: 24.h,
        ),
        SizedBox(width: 8.w),
        Text(
          'Pay for Date',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class PremiumPrice extends StatelessWidget {
  const PremiumPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'N5,000',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }
}

// class PremiumDuration extends StatelessWidget {
//   const PremiumDuration({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       '1 month premium access',
//       style: TextStyle(
//         color: Colors.grey[500],
//         fontSize: 14.sp,
//       ),
//     );
//   }
// }

class PremiumFeaturesList extends StatelessWidget {
  const PremiumFeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FeatureRow(feature: 'Unlimited likes'),
        FeatureRow(feature: 'See who liked you'),
        FeatureRow(feature: 'Premium filters'),
      ],
    );
  }
}

class FeatureRow extends StatelessWidget {
  final String feature;

  const FeatureRow({Key? key, required this.feature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.w),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
            size: 16.h,
          ),
          SizedBox(width: 8.w),
          Text(
            feature,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final String value;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    Key? key,
    required this.value,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.pink : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            PaymentMethodIcon(icon: icon, isSelected: isSelected),
            SizedBox(width: 16.w),
            Expanded(
              child: PaymentMethodInfo(title: title, subtitle: subtitle),
            ),
            PaymentMethodSelector(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const PaymentMethodIcon({
    Key? key,
    required this.icon,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: isSelected ? Colors.pink : Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.grey[600],
        size: 24.h,
      ),
    );
  }
}

class PaymentMethodInfo extends StatelessWidget {
  final String title;
  final String subtitle;

  const PaymentMethodInfo({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}

class PaymentMethodSelector extends StatelessWidget {
  final bool isSelected;

  const PaymentMethodSelector({Key? key, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.pink : Colors.grey.shade300,
          width: 2.w,
        ),
        color: isSelected ? Colors.pink : Colors.transparent,
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              size: 12,
              color: Colors.white,
            )
          : null,
    );
  }
}

class PaymentButton extends StatelessWidget {
  final bool isProcessing;
  final VoidCallback? onPressed;

  const PaymentButton({
    Key? key,
    required this.isProcessing,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        child: isProcessing
            ? const PaymentButtonLoading()
            : const PaymentButtonContent(),
      ),
    );
  }
}

class PaymentButtonLoading extends StatelessWidget {
  const PaymentButtonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20.w,
          height: 20.h,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          'Processing...',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class PaymentButtonContent extends StatelessWidget {
  const PaymentButtonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.favorite, size: 20),
        SizedBox(width: 8.w),
        Text(
          'Pay N5,000',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class SecurityNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Your payment is secured with 256-bit SSL encryption',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey[500],
      ),
    );
  }
}

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check,
        size: 40.h,
        color: Colors.green,
      ),
    );
  }
}

class SuccessTitle extends StatelessWidget {
  const SuccessTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Payment Successful!',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }
}

class SuccessSubtitle extends StatelessWidget {
  const SuccessSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Your premium features are now active',
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 16,
      ),
    );
  }
}

class SuccessMessage extends StatelessWidget {
  const SuccessMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.favorite,
          color: Colors.pink,
          size: 20,
        ),
        SizedBox(width: 8),
        Text(
          'Happy Dating!',
          style: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.w),
        ),
        child: Text(
          'Continue to App',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
