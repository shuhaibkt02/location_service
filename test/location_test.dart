import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
 
  testWidgets('Geolocator test', (WidgetTester tester) async {
    final position = await Geolocator.getCurrentPosition();
    expect(position, isNotNull);
    expect(position.latitude, greaterThan(0));
    expect(position.latitude, lessThanOrEqualTo(90));
  });
}
