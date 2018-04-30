// @see https://en.wikipedia.org/wiki/Deployment_environment#Development
enum Flavor {
  Development,
  Staging,
  Production,
}

class Config {
  static Flavor appFlavor;
}
