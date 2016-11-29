angular.module('webapp')
  .controller('LanchoneteAddController', LanchoneteAddController);

function LanchoneteAddController($http) {
  var vm = this;

  vm.adicionarLanchonete = adicionarLanchonete;

  function adicionarLanchonete(novalanchonete) {
    console.log(novalanchonete);
    var str = "'" + JSON.stringify(novalanchonete) + "'";
    console.log(str);
    $http.post('https://websitehaskell-davicarvalho.c9users.io:8082/locais/cadastro', novalanchonete)
      .success(function () {
        console.log('Produto adicionado com sucesso');
      })
      .error(function (erro) {
        console.log('error', erro);
        console.log(str);
      });
  }
}