class SubscriptionModel {
  final String title;
  final String duration;
  final String amount;
  final String amountPerDuration;
  final String? oldAmount;
  final String value;
  SubscriptionModel(
      {required this.title,
      required this.duration,
      required this.amount,
      required this.amountPerDuration,
      required this.value,
      this.oldAmount});
}

List<SubscriptionModel> subcriptionList = [
  SubscriptionModel(
      title: "1",
      duration: "week",
      value: "1_month",
      amount: "2,900.00₦",
      amountPerDuration: "2,900.00₦/wk"),
  SubscriptionModel(
      title: "1",
      value: "1_month",
      duration: "month",
      amount: "5,900.00₦",
      oldAmount: "12,428₦",
      amountPerDuration: "5,900.00₦/mnt"),
  SubscriptionModel(
      title: "3",
      duration: "months",
      oldAmount: "37,285₦",
      value: "3_months",
      amount: "9,900.00₦",
      amountPerDuration: "3,300.00₦/mnt"),
  SubscriptionModel(
      title: "6",
      duration: "months",
      value: "6_months",
      oldAmount: "74,571₦",
      amount: "17,900.00₦",
      amountPerDuration: "2,983.33.00₦/mnt"),
];
