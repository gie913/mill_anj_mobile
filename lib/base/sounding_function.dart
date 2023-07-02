class SoundingFunction {
  double averageSounding(double sounding1, double sounding2, double sounding3) {
    double average;
    if (sounding1 == sounding2) {
      average = sounding1;
    } else if (sounding1 == sounding3) {
      average = sounding1;
    } else if (sounding2 == sounding3) {
      average = sounding2;
    }
    return average;
  }

  double measureSounding(double average, dynamic surfacePlate) {
    double measureSounding = average + surfacePlate;
    return measureSounding;
  }

  double totalVolume(double volumeMm, double volumeCm) {
    double totalVolume = volumeMm + volumeCm;
    return totalVolume;
  }

  double constantaExpansion(
      dynamic standardTemp, double temperature, double expansionCoefficient) {
    double constantaExpansion =
        1 - ((standardTemp - temperature) * expansionCoefficient);
    return constantaExpansion;
  }

  double totalTonnage(
      double roundingVolume, double density, constantaExpansion) {
    double totalTonnage = roundingVolume * density * constantaExpansion;
    return totalTonnage;
  }
}
