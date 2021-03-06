'use strict';

angular.module('mean.system')
  .controller('IndexController', ['$scope', 'Global', '$state', '$anchorScroll', 'GetProdIdByProdCatCode', 'GetProdDetailByProdCatCode', 'GetAllTravelProduct', 'GetNewPosts',
    function ($scope, Global, $state, $anchorScroll, GetProdIdByProdCatCode, GetProdDetailByProdCatCode, GetAllTravelProduct, GetNewPosts) {
    $scope.global = Global;
    var productCategoryId = '';
    var productCategory = [];

    $scope.viewProduct = function(productCategoryCode) {
        GetProdIdByProdCatCode.get({
            productcategorycode: productCategoryCode
        }, function(result){
            productCategoryId = result.id;
            getProductDetail();
        }); 
    };

    var getProductDetail = function(){
        GetProdDetailByProdCatCode.query({
            productcategoryid: productCategoryId
        }, function(result2){
            productCategory = result2;
            $state.go('searchResult', {prodTravel: productCategory});
            $anchorScroll();
        });
    };

    $scope.initNewPosts = function(){
        //$('#indexModal').modal("show");
        $('#indexModal').modal({
            backdrop: 'static',
            keyboard: false
        },
        $('.container').addClass('blur'));
        $('.navbar').addClass('blur');
        GetNewPosts.query(function (list) {
            $scope.newPosts = list;
            for (var i=0;i<list.length;i++){
                $scope.newPosts[i].imageName = list[i].post_travel_product_documents[0].imageName;
            }
            $('#indexModal').modal("hide");
            $('.container').removeClass('blur');
            $('.navbar').removeClass('blur');
        });
    };

    $scope.initFeatureProduct = function(){
        //$('#indexModal').modal("show");
        $('#indexModal').modal({
            backdrop: 'static',
            keyboard: false
        },
        $('.container').addClass('blur'));
        $('.navbar').addClass('blur');
        GetAllTravelProduct.query(function (list) {
            $scope.featuredProduct = list;
            for (var i=0;i<list.length;i++){
                $scope.featuredProduct[i].imageName = list[i].post_travel_product_documents[0].imageName;
            }
            $('#indexModal').modal("hide");
            $('.container').removeClass('blur');
            $('.navbar').removeClass('blur');
        });
    };

    $scope.goToNewPostsDetails = function (index) {
        $state.go('productdetails', {prodTravel: $scope.newPosts[index]});
        $anchorScroll();
    };

    $scope.goToFeatureProductDetails = function (index) {
        $state.go('productdetails', {prodTravel: $scope.featuredProduct[index]});
        $anchorScroll();
    };
        
}]);
