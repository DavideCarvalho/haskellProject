angular.module('webapp')
.controller('ListaController',ListaController);

function ListaController($http){
  vm = this;
  vm.mensagem = "teste";

  vm.listaLanchonetes = [];

  vm.carregarLanchonetes = carregarLanchonetes;
  function carregarLanchonetes(){
    $http.get('https://haskell-web-rinama07.c9users.io/locais/lista')
    .success(function(data){
      vm.listaLanchonetes = data;
    })
    .error(function(error){
      console.log(error);
    });
  }

  carregarLanchonetes();

}
