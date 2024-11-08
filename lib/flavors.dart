enum Flavor {
  dev,
  stg,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'City dev';
      case Flavor.stg:
        return 'City stg';
      case Flavor.prod:
        return 'City';
      default:
        return 'title';
    }
  }

}
