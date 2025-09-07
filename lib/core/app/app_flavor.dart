enum FlavorStatus {
  production,
  development,
  staging,
}

class AppFlavor {
  static FlavorStatus appFlavor = FlavorStatus.production;

  static FlavorStatus get getFlavor {
    switch (appFlavor) {
      case FlavorStatus.production:
        return FlavorStatus.production;
      case FlavorStatus.development:
        return FlavorStatus.development;
      case FlavorStatus.staging:
        return FlavorStatus.staging;
    }
  }
}
