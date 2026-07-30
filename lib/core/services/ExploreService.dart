import 'package:test/core/model/ExploreItem.dart';
import 'package:test/core/model/ExploreUpdate.dart';

class ExploreService {
  static List<ExploreItem> listExploreItem =
      listExploreItemRawData.map((data) => ExploreItem.fromJson(data)).toList();
  static List<ExploreUpdate> listExploreUpdateItem =
      listExploreUpdateItemRawData
          .map((data) => ExploreUpdate.fromJson(data))
          .toList();
}

var listExploreItemRawData = [
  {'image_url': 'assets/images/explore1.jpg'},
  {'image_url': 'assets/images/explore2.jpg'},
  {'image_url': 'assets/images/explore3.jpg'},
  {'image_url': 'assets/images/explore4.jpg'},
  {'image_url': 'assets/images/explore5.jpg'},
  {'image_url': 'assets/images/explore6.jpg'},
  {'image_url': 'assets/images/explore7.jpg'},
  {'image_url': 'assets/images/explore8.jpg'},
  {'image_url': 'assets/images/explore9.jpg'},
  {'image_url': 'assets/images/explore10.jpg'},
  {'image_url': 'assets/images/explore11.jpg'},
  {'image_url': 'assets/images/explore12.jpg'},
  {'image_url': 'assets/images/explore13.jpg'},
  {'image_url': 'assets/images/explore14.jpg'},
  {'image_url': 'assets/images/explore15.jpg'},
  {'image_url': 'assets/images/explore16.jpg'},
];

var listExploreUpdateItemRawData = [
  {
    'logo_url': 'assets/images/fiberlogo.jpg',
    'image': 'assets/images/fiber_update.jpg',
    'store_name': 'FiberNet Solutions',
    'caption':
        'High-performance single-mode fiber optic cable for long-distance digital communication. Designed for stable data transfer with minimal latency and maximum signal integrity.',
  },
  {
    'logo_url': 'assets/images/routerlogo.jpg',
    'image': 'assets/images/router_update.jpg',
    'store_name': 'NetLink Systems',
    'caption':
        'Next-generation Wi-Fi 6 router with dual-band support, offering seamless internet coverage for homes and offices. Ideal for streaming, gaming, and IoT device connectivity.',
  },
];
