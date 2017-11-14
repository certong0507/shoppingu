'use strict';

angular.module('mean.auth').controller('signUp', ['$scope', '$window', 'Global', '$state', 'SignUp', function ($scope, $window, Global, $state, SignUp) {
    $scope.global = Global;

    $scope.signUp = function () {
        var signUp = new SignUp({
            firstName: this.firstName,
            lastName: this.lastName,
            email: this.email,
            phoneNumber: this.phoneNumber,
            password: this.password,
            confirmPassword: this.confirmPassword
        });

        signUp.$save(function (response) {
            if (response.status === 'success') {
                $window.location.href = '/';
            }
        });
    };


}]);