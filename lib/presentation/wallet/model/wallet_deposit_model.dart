class WalletDepositModel {
  final String credit;
  final String amount;
  WalletDepositModel({
    required this.credit,
    required this.amount,
  });
}

List<WalletDepositModel> depostTypes = [
  WalletDepositModel(credit: "100", amount: "N100.00"),
  WalletDepositModel(credit: "200", amount: "N150.00"),
  WalletDepositModel(credit: "250", amount: "N200.00"),
  WalletDepositModel(credit: "300", amount: "N250.00"),
  WalletDepositModel(credit: "400", amount: "N300.00"),
  WalletDepositModel(credit: "500", amount: "N350.00"),
  WalletDepositModel(credit: "800", amount: "N600.00"),
  WalletDepositModel(credit: "1000", amount: "700.00"),
  WalletDepositModel(credit: "1500", amount: "N1000.00"),
  // WalletDepositModel(credit: "800", amount: "N600.00"),
];
