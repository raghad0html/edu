import 'package:test/core/model/Cart.dart';

class CartService {
  static List<Cart> cartData =
      cartRawData.map((data) => Cart.fromJson(data)).toList();
}

var cartRawData = [
  {
    'image': [
      'assets/images/fiber-internet.jpg',
      'assets/images/nikegrey.jpg',
    ],
    'name': 'OpticTech',
    'price': 1429000,
    'count': 1,
  },
  // 2
  {
    'image': [
      'assets/images/cell_tower_1_cam008_wire.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Telecom Tower 30m",
    'price': 1429000,
    'count': 1,
  },
  // 3
  {
    'image': [
      'assets/images/router.jpg',
      'assets/images/nikehoodie.jpg',
    ],
    'name': "TP-Link AX3000 Wi-Fi 6 Router",
    'price': 849000,
    'count': 1,
  },
];
