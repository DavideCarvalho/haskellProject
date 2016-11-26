angular.module('webapp')
.controller('ListaController',ListaController);

function ListaController($http){
  vm = this;
  vm.mensagem = "teste";

  vm.listaLanchonetes = [];

  vm.listaProdutos = [
  ];

  vm.carregarLanchonetes = carregarLanchonetes;
  function carregarLanchonetes(){
    $http.get('https://websitehaskell-davicarvalho.c9users.io/locais/lista')
    .success(function(data){
      vm.listaLanchonetes = data.resp;
    })
    .error(function(error){
      console.log(error);
    });
  }

  vm.carregarProdutos = carregarProdutos;
  function carregarProdutos(){
    $http.get('https://websitehaskell-davicarvalho.c9users.io/produtos/lista')
    .success(function(data){
      vm.listaProdutos = data.resp;
    })
    .error(function(error){
      console.log(error);
    });
  }

  carregarLanchonetes();
  carregarProdutos();

}
