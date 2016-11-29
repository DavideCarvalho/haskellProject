angular.module('webapp',['MinhasDiretivas','ngRoute'])
.config(function($routeProvider,$locationProvider){
  $locationProvider.html5Mode(true);

  $routeProvider
  .when('/',{
    templateUrl:'views/listaLanchonetes.html',
    controller:'ListaLanchonetesController as listaLanchonetes'
  })
  .when('/lanchonete/:lanchoneteId',{
    templateUrl:'views/LanchoneteProdutos.html',
    controller:'LanchoneteProdutosController as lanchoneteprodutos'
  })
  .when('/produtoadd',{
    templateUrl:'views/produtoadd.html',
    controller:'ProdutoAddController as produtoadd'
  })
  .when('/lanchoneteadd',{
    templateUrl:'views/lanchoneteadd.html',
    controller:'LanchoneteAddController as lanchoneteadd'
  })
  .otherwise({
    redirectTo:'/'
  });
});
