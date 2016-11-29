angular.module('webapp')
.controller('ProdutoAddController',ProdutoAddController);

function ProdutoAddController($http){
  var vm = this;

  vm.adicionarProduto = adicionarProduto;

  function adicionarProduto (novoproduto){
    console.log(novoproduto);
    var str= "'" + JSON.stringify(novoproduto) + "'";
    console.log(str);
    $http.post('https://websitehaskell-davicarvalho.c9users.io:8082/produtos/cadastro',novoproduto)
    .success(function(){
      console.log('Produto adicionado com sucesso');
    })
    .error(function(erro){
      console.log('error',erro);
      console.log(str);
    });
  }
}