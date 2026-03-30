function fn() {
  var env = karate.env; // Aquí puedes capturar el entorno (ej. dev, qa, prod)
  karate.log('El entorno de ejecución es:', env);

  var config = {
    baseUrl: 'https://reqres.in/api'
  };

  // Puedes configurar timeouts si la API del reto es lenta
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);

  return config;
}