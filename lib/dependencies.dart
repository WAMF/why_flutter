import 'package:kiss_dependencies/kiss_dependencies.dart';
import 'services/example_service.dart';
import 'services/presentation_service.dart';

void setupDependencies() {
  // Register lazy singletons for services
  registerLazy<ExampleService>(() => ExampleServiceImpl());
  registerLazy<PresentationService>(() => PresentationServiceImpl());
  
  // You can register more services here as they are created
  // Example: registerLazy<ApiService>(() => ApiService());
  // Example: registerLazy<DatabaseService>(() => DatabaseService());
  // Example: registerLazy<AuthService>(() => AuthService());
  
  // Use resolve<ServiceType>() to get instances when needed
}