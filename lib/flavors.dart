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

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://672ba4801600dda5a9f5dcbf.mockapi.io/api/v1';
      case Flavor.stg:
        return 'https://672ba4801600dda5a9f5dcbf.mockapi.io/api/v1';
      case Flavor.prod:
        return 'https://672ba4801600dda5a9f5dcbf.mockapi.io/api/v1';
      default:
        return 'https://672ba4801600dda5a9f5dcbf.mockapi.io/api/v1';
    }
  }
}
