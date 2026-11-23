function fn() {
  var env = karate.env || 'dev'; // get system property 'karate.env'
  karate.log('karate.env =', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
    baseUrl: 'https://webservice.toscacloud.com/api/v1'
  }

  if (env == 'staging') {
    config.baseUrl = 'https://staging.example.com/api/v1';   // exemple d'un autre environnement
  }
  return config;
}