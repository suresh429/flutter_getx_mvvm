abstract class AppEnvironment {
  static late String baseApiUrl;
  static late String baseWebUrl;
  static late String title;
  static late int apiTimeout;
  static const String apiKey = "AIzaSyCfc46u8GKalnAS8ODg1Zo1T_Xg0u7RNDM";
  static late Environment _environment;
  static Environment get environment => _environment;

  static setupEnv(Environment env) {
    _environment = env;
    switch (env) {
      case Environment.dev:
        {
          baseApiUrl = 'https://touch-a-life-dev.web.app/api/v1/';
          baseWebUrl = 'https://talleaders-dev.vercel.app/';
          title = "TALLeaders dev";
          apiTimeout = 30000;
          break;
        }
      case Environment.prod: {
        baseApiUrl = 'https://v1.talgiving.org/api/v1/';
        baseWebUrl = 'https://talleaders-prod.vercel.app/';
        title = "TALLeaders";
        apiTimeout = 30000;
        break;
      }
    }
  }

}

enum Environment {
  dev,
  prod
}