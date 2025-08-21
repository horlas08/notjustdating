import 'dart:convert';

// class WalletTransactionModel {
//   final String title;
//   final String dateTime;
//   final String value;
//   final String type;
//   WalletTransactionModel({
//     required this.title,
//     required this.dateTime,
//     required this.value,
//     required this.type,
//   });

//   WalletTransactionModel copyWith({
//     String? title,
//     String? dateTime,
//     String? value,
//     String? type,
//   }) {
//     return WalletTransactionModel(
//       title: title ?? this.title,
//       dateTime: dateTime ?? this.dateTime,
//       value: value ?? this.value,
//       type: type ?? this.type,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'dateTime': dateTime,
//       'value': value,
//       'type': type,
//     };
//   }

//   factory WalletTransactionModel.fromMap(Map<String, dynamic> map) {
//     return WalletTransactionModel(
//       title: map['title'] ?? '',
//       dateTime: map['dateTime'] ?? '',
//       value: map['value'] ?? '',
//       type: map['type'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory WalletTransactionModel.fromJson(String source) =>
//       WalletTransactionModel.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'WalletTransactionModel(title: $title, dateTime: $dateTime, value: $value, type: $type)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is WalletTransactionModel &&
//         other.title == title &&
//         other.dateTime == dateTime &&
//         other.value == value &&
//         other.type == type;
//   }

//   @override
//   int get hashCode {
//     return title.hashCode ^ dateTime.hashCode ^ value.hashCode ^ type.hashCode;
//   }
// }

// List<WalletTransactionModel> transactionList = [
//   WalletTransactionModel(
//       title: "paracetamol tablet 7 purchase",
//       dateTime: "Aug 27, 2022 at 5:19pm",
//       value: "50 Crdt",
//       type: "debit"),
//   WalletTransactionModel(
//       title: "Healthcare access",
//       dateTime: "Aug 27, 2022 at 5:19pm",
//       value: "70 Crdt",
//       type: "debit"),
//   WalletTransactionModel(
//       title: "paracetamol tablet 7 purchase",
//       dateTime: "Aug 27, 2022 at 5:19pm",
//       value: "50 Crdt",
//       type: "debit"),
//   WalletTransactionModel(
//       title: "Doctor consultation",
//       dateTime: "Aug 27, 2022 at 5:19pm",
//       value: "250 Crdt",
//       type: "debit"),
//   WalletTransactionModel(
//       title: "paracetamol tablet 7 purchase",
//       dateTime: "Aug 27, 2022 at 5:19pm",
//       value: "50 Crdt",
//       type: "debit"),
//   WalletTransactionModel(
//       title: "paracetamol tablet 7 purchase",
//       dateTime: "Aug 27, 2022 at 5:19pm",
//       value: "50 Crdt",
//       type: "debit"),
// ];

final data = {
  "data": {
    "transactions": [
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 7,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "credit",
        "payment_type": "WALLET",
        "narration": "Gift received from Adebowale Lawal",
        "created_at": "2024-09-21 19:30:26"
      },
      {
        "id": 8,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 100,
        "status": "paid",
        "type": "debit",
        "payment_type": "WALLET",
        "narration": "Gift sent to Adebowale Lawal",
        "created_at": "2024-09-21 19:54:05"
      },
      {
        "id": 11,
        "gift": {
          "name": "Flower",
          "image": "https://social-media.test/uploads/1726916090_images_(1).png"
        },
        "amount": 50,
        "status": "paid",
        "type": "debit",
        "payment_type": "WALLET",
        "narration": "Gift sent to Adebowale Lawal",
        "created_at": "2024-09-21 20:06:33"
      }
    ],
    "current_page": 1,
    "per_page": 10,
    "total": 3,
    "first_page_url":
        "https://social-media.test/api/user/gift/transaction?page=1",
    "prev_page_url": null,
    "next_page_url": null,
    "last_page_url":
        "https://social-media.test/api/user/gift/transaction?page=1"
  }
};
