'use strict';

angular.module('mean.articles')
  .controller('SearchResultController', ['$scope', 'Global', '$stateParams', '$state', 'GetProdCatAndSubCat', 'GetProductDetailByProdSubCatID', function($scope, Global, $stateParams, $state, GetProdCatAndSubCat, GetProductDetailByProdSubCatID){
    $scope.global = Global;
    $scope.profileId = $stateParams.profileId;
    
    $scope.productTravel = $stateParams.prodTravel;
    // $scope.productRequest = $stateParams.prodRequest;
    
    $scope.tFilteredTodos = [];
    $scope.tCurrentPage = 1;
    $scope.tNumPerPage = 12;
    $scope.tMaxSize = 5;

    $scope.rFilteredTodos = [];
    $scope.rCurrentPage = 1;
    $scope.rNumPerPage = 12;
    $scope.rMaxSize = 5;

    $scope.menuTree = function() {
      GetProdCatAndSubCat.query(function (result) {
        $scope.menuTreeResult = result;
      });
    };

    $scope.openFirst = function (index) {
      if ($('#'+$scope.menuTreeResult[index].id).hasClass("expanded"))
      {
        $('#'+$scope.menuTreeResult[index].id).removeClass("expanded");
      }
      else
      {
        $('#'+$scope.menuTreeResult[index].id).addClass("expanded");
        for (var i=0; i<$scope.menuTreeResult.length;i++){
          if ($scope.menuTreeResult[i] !== $scope.menuTreeResult[index])
            $('#'+$scope.menuTreeResult[i].id).removeClass("expanded");
        }
      }
      $scope.count = index;
    };

    $scope.getProductDetail = function (index) {
      GetProductDetailByProdSubCatID.query({
        productSubCatId: $scope.menuTreeResult[$scope.count].product_sub_categories[index].id
      },function(result) {
        $scope.product = result;
        $scope.productTravel = [];
        $scope.productRequest = [];
        $scope.todos = [];
        $scope.tFilteredTodos = [];
        // $scope.rTodos = [];
        // $scope.rFilteredTodos = [];
        $scope.tCurrentPage = 1;
        // $scope.rCurrentPage = 1;
        var begin = (($scope.tCurrentPage - 1) * $scope.tNumPerPage);
        var end = begin + $scope.tNumPerPage;
        // var rBegin = (($scope.rCurrentPage - 1) * $scope.rNumPerPage);
        // var rEnd = rBegin + $scope.rNumPerPage;
        
        for(var i=0;i<$scope.product.length;i++){
          // if ($scope.product[i].t_product.PostType === 0)
          // {
            //$scope.product[i].post_travel_product_documents[0].imagePath = $scope.product[i].post_travel_product_documents[0].imagePath.substring(6, 10);
            $scope.product[i].imageName = $scope.product[i].post_travel_product_documents[0].imageName;
            $scope.productTravel.push($scope.product[i]);
            $scope.todos.push($scope.product[i]);
            $scope.tFilteredTodos = $scope.todos.slice(begin, end);
            $scope.tTotalItems = $scope.productTravel.length;
          // }
          // else
          // {
          //   $scope.productRequest.push($scope.product[i]);
          //   $scope.rTodos.push($scope.product[i]);
          //   $scope.rFilteredTodos = $scope.rTodos.slice(rBegin, rEnd);
          //   $scope.rTotalItems = $scope.productRequest.length;
          // }
        }
      });
    };

    //Tab
    // $scope.selectedTab = function (number){
    //   if (number === 1){
    //     $('#profile1').addClass("active");
    //     $('#request').removeClass("active");
    //   }
    //   else{
    //     $('#profile1').removeClass("active");
    //     $('#request').addClass("active");
    //   }
    // };

    // Pagination setup
    if ($scope.productTravel != null)
    {
      $scope.makeTodos = function() {
        $scope.todos = [];
        for (var i=0;i<$scope.productTravel.length;i++) {
          // $scope.todos.push($scope.productTravel[i]);
          $scope.productTravel[i].imageName = $scope.productTravel[i].post_travel_product_documents[0].imageName;
          $scope.todos.push($scope.productTravel[i]);
        }
        // $scope.rTodos = [];
        // for (var j=0;j<$scope.productRequest.length;j++) {
        //   $scope.rTodos.push($scope.productRequest[j]);
        // }
      };
      $scope.makeTodos(); 
      
      $scope.isTravel = function (number){
        if (number === 0)
        {
          $scope.$watch("tCurrentPage + tNumPerPage", function() {
            var begin = (($scope.tCurrentPage - 1) * $scope.tNumPerPage);
            var end = begin + $scope.tNumPerPage;
            $scope.tFilteredTodos = $scope.todos.slice(begin, end);
          });
        }
        else
        {
          // $scope.$watch("rCurrentPage + rNumPerPage", function() {
          //   var rBegin = (($scope.rCurrentPage - 1) * $scope.rNumPerPage);
          //   var rEnd = rBegin + $scope.rNumPerPage;
          //   $scope.rFilteredTodos = $scope.rTodos.slice(rBegin, rEnd);
          // });
        }
      };
      $scope.tTotalItems = $scope.productTravel.length;
      // $scope.rTotalItems = $scope.productRequest.length;
    }

    // Shop Categories Widget
    //------------------------------------------------------------------------------
    // var categoryToggle = $('.widget-categories .has-children > a');

    // function closeCategorySubmenu() {
    //   categoryToggle.parent().removeClass('expanded');
    // }
    // categoryToggle.on('click', function(e) {
    //   if($(e.target).parent().is('.expanded')) {
    //     closeCategorySubmenu();
    //   } else {
    //     closeCategorySubmenu();
    //     $(this).parent().addClass('expanded');
    //   }
    // });

  }]);

