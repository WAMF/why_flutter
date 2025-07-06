abstract class ExampleService {
  String getMessage();
}

class ExampleServiceImpl implements ExampleService {
  @override
  String getMessage() {
    return 'Hello from ExampleService!';
  }
}