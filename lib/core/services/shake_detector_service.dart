import 'package:shake/shake.dart';

class EmergencyShakeDetector {
  final Function onShake;
  final int shakeThreshold;
  int shakeCount = 0;

  EmergencyShakeDetector({required this.onShake, this.shakeThreshold = 3}) {}
  void startListening() {
    ShakeDetector.autoStart(onPhoneShake: (shakeEvent) {
        shakeCount++;
        if(shakeCount >= shakeThreshold) {
          onShake();
          shakeCount = 0; // Reset after triggering
        }
    });
  }
}
