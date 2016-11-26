angular.module('webapp',['MinhasDiretivas','ngRoute'])
.config(function($routeProvider,$locationProvider){
  $locationProvider.html5Mode(true);

  $routeProvider
  .when('/',{
    templateUrl:'views/listaLanchonetesProdutos.html',
    controller:'ListaController as lista'
  })
  .when('/login',{
    templateUrl:'views/login.html',
    controller:'LoginController as login'
  })
  .otherwise({
    redirectTo:'/'
  });
});
