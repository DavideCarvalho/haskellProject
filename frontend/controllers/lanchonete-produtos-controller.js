angular.module('webapp')
.controller('LanchoneteProdutosController',LanchoneteProdutosController);

function LanchoneteProdutosController($http, $routeParams){
  var vm = this;

  vm.produtos = [];

  vm.carregarProdutos = carregarProdutos;

  vm.lanchoneteId = $routeParams.lanchoneteId;
  console.log(vm.lanchoneteId);
  console.log('teste');

  vm.carregarProdutos = carregarProdutos;
  function carregarProdutos(){
    $http.get()
  }
}