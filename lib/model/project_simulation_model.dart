class BomItem {
  final String name;
  final int quantity;
  final String reason; // سبب اختيار هذه القطعة بالذات

  BomItem({required this.name, required this.quantity, required this.reason});
}

class ProjectSimulationResult {
  final String projectType;
  final List<BomItem> bomList;
  final String topologyImageUrl;
  final List<String> steps;

  ProjectSimulationResult({
    required this.projectType,
    required this.bomList,
    required this.topologyImageUrl,
    required this.steps,
  });
}