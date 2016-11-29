angular.module('MinhasDiretivas',[])
.directive('minhaNav',function(){
  var ddo = {};
  ddo.restrict="AE";
  ddo.templateUrl = "directives/minha-nav.html";
  return ddo;
})
.directive('minhasLanchonetes',function(){
  var ddo = {};
  ddo.restrict="AE";
  ddo.templateUrl = 'directives/minhas-lanchonetes.html';
  return ddo;
});