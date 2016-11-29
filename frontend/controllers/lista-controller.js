angular.module('webapp')
.controller('ListaLanchonetesController',ListaController);

function ListaController($http){
  vm = this;
  vm.mensagem = "teste";

  //Lista contendo o produto, a descrição,a lanchonete e o preço
  vm.lista = [];

  vm.carregarLista = carregarLista;
  function carregarLista(){
    $http.get('https://websitehaskell-davicarvalho.c9users.io:8082/locais/lista')
    .success(function(data){
      vm.lista=data.resp;
    })
    .error(function(error){
      console.log(error);
    });
  }

  vm.excluirLanchonete = excluirLanchonete;
  function excluirLanchonete(LanchoneteId){

  }

  carregarLista();

}
