import 'package:flutter/material.dart';
import 'package:test/core/model/Product.dart';

class ProductService {
  static List<Product> productData =
      productRawData.map((data) => Product.fromJson(data)).toList();
  static List<Product> searchedProductData =
      searchedProductRawData.map((data) => Product.fromJson(data)).toList();
}

var productRawData = [
  {
    'image': [
      'assets/images/fiber-internet.jpg',
      'assets/images/Fiber.glb',
    ],
    'name': 'Fiber Optic Cable - Single Mode',
    'rating': 4.5,
    'description':
        'High-speed single mode fiber optic cable, suitable for long-distance optical communications.',
    'store_name': 'OpticTech',
    'category': 'Fiber Optics',
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Eng. Khaled',
        'review':
            'Reliable cable with minimal signal loss. Recommended for backbone connections.',
        'rating': 5.0,
      }
    ]
  },
  {
    'image': [
      'assets/images/cell_tower_1_cam008_wire.jpg',
      'assets/images/kamasnaey.glb',
    ],
    'name': 'Telecom Tower 30m',
    'rating': 4.8,
    'description':
        'Durable 30-meter telecom tower for cellular and wireless internet distribution.',
    'store_name': 'SkyTower Co.',
    'category': 'Towers',
    'reviews': [
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Eng. Lina',
        'review': 'Excellent build quality and easy to assemble.',
        'rating': 4.5,
      }
    ]
  },
  {
    'image': [
      'assets/images/router.jpg',
      'assets/images/router.glb',
    ],
    'name': 'TP-Link AX3000 Wi-Fi 6 Router',
    'rating': 4.7,
    'description':
        'Advanced Wi-Fi 6 router with high-speed data transfer and multiple antennas.',
    'store_name': 'ConnectZone',
    'category': 'Routers',
    'reviews': [
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Ahmed H.',
        'review': 'Great performance for both streaming and gaming.',
        'rating': 4.7,
      }
    ]
  },
  {
    'image': [
      'assets/images/ethernet.jpg',
      'assets/images/eshara.glb',
    ],
    'name': 'CAT6 Ethernet Cable - 10m',
    'rating': 4.2,
    'description': 'Shielded CAT6 cable for fast and secure LAN connections.',
    'store_name': 'Cable World',
    'category': 'Cables',
    'reviews': [
      {
        'photo_url': 'assets/images/avatar4.jpg',
        'name': 'Sara A.',
        'review': 'Works perfectly with our office network setup.',
        'rating': 4.0,
      }
    ]
  },
  {
    'image': [
      'assets/images/satellite.png',
      'assets/images/Orbital.glb',
    ],
    'name': 'Satellite Dish 90cm',
    'rating': 4.6,
    'description':
        'High gain satellite dish for stable reception in all weather conditions.',
    'store_name': 'OrbitSat',
    'category': 'Satellites',
    'reviews': [
      {
        'photo_url': 'assets/images/avatar5.jpg',
        'name': 'Maher T.',
        'review': 'Strong signal and easy alignment with satellite.',
        'rating': 4.5,
      }
    ]
  },
];

var searchedProductRawData = [
  {
    'image': [
      'assets/images/search/searchitem6.jpg',
      'assets/images/nikegrey.jpg',
    ],
    'name': 'Air Jordan XXXVI SE PF',
    'price': 2729000,
    'rating': 4.0,
    'description':
        'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': Colors.black,
      },
      {
        'name': 'blueGrey',
        'color': Colors.blueGrey[200],
      },
      {
        'name': 'pink',
        'color': Colors.pink[100],
      },
      {
        'name': 'white',
        'color': Colors.white,
      },
    ],
    'sizes': [
      {
        'size': '36.0',
        'name': '36',
      },
      {
        'size': '37.0',
        'name': '37',
      },
      {
        'size': '38.0',
        'name': '38',
      },
      {
        'size': '42.0',
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },
  // 2
  {
    'image': [
      'assets/images/search/searchitem3.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Air Jordan 1 Retro OG",
    'price': 1749000,
    'rating': 5.0,
    'description':
        'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': Colors.black,
      },
      {
        'name': 'blueGrey',
        'color': Colors.blueGrey[200],
      },
      {
        'name': 'pink',
        'color': Colors.pink[100],
      },
      {
        'name': 'white',
        'color': Colors.white,
      },
    ],
    'sizes': [
      {
        'size': '36.0',
        'name': '36',
      },
      {
        'size': '37.0',
        'name': '37',
      },
      {
        'size': '38.0',
        'name': '38',
      },
      {
        'size': '42.0',
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },
  // 3

  {
    'image': [
      'assets/images/search/searchitem5.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Jordan Point Lane",
    'price': 2099000,
    'rating': 5.0,
    'description':
        'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': Colors.black,
      },
      {
        'name': 'blueGrey',
        'color': Colors.blueGrey[200],
      },
      {
        'name': 'pink',
        'color': Colors.pink[100],
      },
      {
        'name': 'white',
        'color': Colors.white,
      },
    ],
    'sizes': [
      {
        'size': '36.0',
        'name': '36',
      },
      {
        'size': '37.0',
        'name': '37',
      },
      {
        'size': '38.0',
        'name': '38',
      },
      {
        'size': '42.0',
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },

  // 4

  {
    'image': [
      'assets/images/search/searchitem2.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Air Jordan 4 Crimson",
    'price': 2779000,
    'rating': 4.0,
    'description':
        'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': Colors.black,
      },
      {
        'name': 'blueGrey',
        'color': Colors.blueGrey[200],
      },
      {
        'name': 'pink',
        'color': Colors.pink[100],
      },
      {
        'name': 'white',
        'color': Colors.white,
      },
    ],
    'sizes': [
      {
        'size': '36.0',
        'name': '36',
      },
      {
        'size': '37.0',
        'name': '37',
      },
      {
        'size': '38.0',
        'name': '38',
      },
      {
        'size': '42.0',
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },

  // 5

  {
    'image': [
      'assets/images/search/searchitem4.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Jordan Delta 2 SE",
    'price': 2099000,
    'rating': 5.0,
    'description':
        'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': Colors.black,
      },
      {
        'name': 'blueGrey',
        'color': Colors.blueGrey[200],
      },
      {
        'name': 'pink',
        'color': Colors.pink[100],
      },
      {
        'name': 'white',
        'color': Colors.white,
      },
    ],
    'sizes': [
      {
        'size': '36.0',
        'name': '36',
      },
      {
        'size': '37.0',
        'name': '37',
      },
      {
        'size': '38.0',
        'name': '38',
      },
      {
        'size': '42.0',
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },

  // 5

  {
    'image': [
      'assets/images/search/searchitem1.jpg',
      'assets/images/nikeblack.jpg',
    ],
    'name': "Jordan One Take 3",
    'price': 1099000,
    'rating': 4.0,
    'description':
        'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
    'store_name': 'Nike Indonesia',
    'colors': [
      {
        'name': 'black',
        'color': Colors.black,
      },
      {
        'name': 'blueGrey',
        'color': Colors.blueGrey[200],
      },
      {
        'name': 'pink',
        'color': Colors.pink[100],
      },
      {
        'name': 'white',
        'color': Colors.white,
      },
    ],
    'sizes': [
      {
        'size': '36.0',
        'name': '36',
      },
      {
        'size': '37.0',
        'name': '37',
      },
      {
        'size': '38.0',
        'name': '38',
      },
      {
        'size': '42.0',
        'name': '42',
      },
    ],
    'reviews': [
      {
        'photo_url': 'assets/images/avatar1.jpg',
        'name': 'Uchiha Sasuke',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar2.jpg',
        'name': 'Uzumaki Naruto',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
      {
        'photo_url': 'assets/images/avatar3.jpg',
        'name': 'Kurokooo Tetsuya',
        'review':
            'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
        'rating': 4.0,
      },
    ]
  },
];
