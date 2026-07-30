import 'package:test/core/model/Category.dart';

class CategoryService {
  static List<Category> categoryData =
      categoryRawData.map((data) => Category.fromJson(data)).toList();
}

var categoryRawData = [
  {
    'featured': true,
    'icon_url': 'assets/icons/Fiber-optics.svg',
    'name': 'Fiber Optics',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Routers.svg',
    'name': 'Routers',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Switches.svg',
    'name': 'Switches',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Cables.svg',
    'name': 'Cables',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Satellite-dishes.svg',
    'name': 'Satellite Dishes',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Antennas.svg',
    'name': 'Antennas',
  },
  {
    'featured': false,
    'icon_url': 'assets/icons/Access-points.svg',
    'name': 'Access Points',
  },
];
