import 'package:kiss_dependencies/kiss_dependencies.dart';
import 'services/presentation_service.dart';

void setupDependencies() {
  registerLazy<PresentationService>(() => PresentationService());
}
