# Location-based Services App in Flutter

This Flutter application demonstrates location-based services, enabling users to collect GPS coordinates, store them in a local database, and visualize their path on a map.

- **User Interface:** Simple and intuitive interface with a map view.
- **Location Data Collection:** Collect GPS coordinates in real-time and display them on the map.
- **Database Storage:** Store collected GPS coordinates in a local database for offline access.
- **Logical Operations:** Draw lines on the map to connect collected coordinates and visualize the user's path.
- **Error Handling:** Proper error handling for scenarios such as no GPS signal and database errors.
- **Testing:** Unit tests for GPS coordinate collection and database storage functionality.

## Screenshots

![mapView](https://github.com/shuhaibkt02/location_service/assets/111732518/e02921f6-c266-4f99-b6f3-024c8a8fc859) ![locations](https://github.com/shuhaibkt02/location_service/assets/111732518/0d959c53-e5ed-4b6c-a6d5-64ae9839b0f0)



## Installation

1. Clone the repository:

```bash
git clone https://github.com/your_username/location_services_flutter.git
```
2. Navigate to the project directory:
```bash
cd location_services_flutter
```
3. Install dependencies And run
```bash
flutter pub get && flutter run 
```

# Usage
- Launch the app on your device.
- Grant necessary permissions for GPS access.
- Tap the "Collect Location" button to start collecting GPS coordinates.
- View the real-time display of collected coordinates on the map.
- Use the "View History" button to see previously collected coordinates.
- Observe the drawn lines on the map, connecting the collected coordinates.
