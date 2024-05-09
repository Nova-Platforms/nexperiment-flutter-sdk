# Nexperiment SDK

Nexperiment SDK is a Dart package that simplifies the integration of your Flutter/Dart applications with the Nexperiment platform. Nexperiment is a experimentation platform that empower teams to continuous introduce new features, crafting a tailored and personalized user experience, while minimizing rollout risks. 

## Features

- **Feature Toggles**: Easily retrieve feature toggles from the Nexperiment platform based on the provided key.
- **Remote Configurations**: Fetch remote configurations from Nexperiment to dynamically adjust your application's behavior.

## Installation

To use the Nexperiment SDK in your Flutter/Dart project, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  nexperiment_sdk: ^1.0.0
```

Then, run flutter pub get to install the package.

## Usage

```dart
import 'package:nexperiment_sdk/nexperiment_sdk.dart';

void main() async {
  // Initialize the SDK with your Nexperiment API credentials
  final sdk = Nexperiment();
  await sdk.init('YOUR_BASE_URL', 'YOUR_API_KEY', 'YOUR_API_SECRET');

  // Retrieve a feature toggle
  final toggle = await sdk.getToggle('feature_toggle_key');
  print(toggle.value);

  // Retrieve a remote configuration
  final config = await sdk.getConfig('remote_config_key');
  print(config.value);
}
```

Replace 'YOUR_BASE_URL', 'YOUR_API_KEY', and 'YOUR_API_SECRET' with your actual Nexperiment API credentials.

## Contributing

Contributions to the Nexperiment SDK are welcome! If you encounter any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request on GitHub.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
Feel free to customize the README further to include additional information or instructions specific to your project or use case.
