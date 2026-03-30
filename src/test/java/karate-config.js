function fn() {
  var env = karate.env;
  if (!env) {
    env = 'qa';
  }

  var config = {
    baseUrl: 'https://petstore.swagger.io/v2'
  };

  if (env === 'dev') {
    config.baseUrl = 'http://localhost:8080/v2';
  }

  karate.configure('headers', {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  });

  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 10000);
  karate.configure('ssl', true);

  return config;
}