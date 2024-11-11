abstract class AppEnvironment {
  //static late String headerKey;
  static late String baseApiUrl;
  static late String title;
  static late Environment _environment;
  static Environment get environment => _environment;

  static setupEnv(Environment env) {
    _environment = env;
    switch (env) {
      case Environment.dev:
        {
          //headerKey = 'Authorization';
          baseApiUrl = 'https://touch-a-life-dev.web.app/api/v1/';
          title = "TALLeaders dev";
          break;
        }
      case Environment.prod: {
       // headerKey = 'Authorization';
        baseApiUrl = 'https://v1.talgiving.org/api/v1/';
        title = "TALLeaders";
        break;
      }
    }
  }


}

enum Environment {
  dev,
  prod
}