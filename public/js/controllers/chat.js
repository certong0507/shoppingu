'use strict';

angular.module('mean')
  .controller("ChatController", ['$scope', '$stateParams', '$window', 'GetUserProfileById', 'socket',
    function ($scope, $stateParams, $window, GetUserProfileById, socket) {

    $scope.hasLogined = false;
    $scope.users = {};
    $scope.inbox_id={};
    $scope.productTravel = $stateParams.prodTravel;
    var userId = $window.sessionStorage.getItem("id");
    var listUsers = [];
    $scope.messages = [];

    // Triggered when leave the page
    $scope.$on("$destroy", function() {
        listUsers.forEach(element => {
            socket.emit('checkUserMsgNull', {inbox_id: element.inbox_id, user_2: element.user_2});
        });
        
        socket.getSocket().removeListener("returnFriendList");
        socket.getSocket().removeListener("notifications_1");
        socket.getSocket().removeListener("notifications");
        socket.getSocket().removeListener("inbox_id2");
        socket.getSocket().removeListener("all_messages");
        socket.getSocket().removeListener("seen_notification");
        socket.getSocket().removeListener("new_message");
        socket.getSocket().removeListener("inbox_id");
    });

    $scope.initUserProfile = function() {
        GetUserProfileById.get({
            id: userId
        }, function(result) {
            $scope.loginId = result.loginId;
            //$scope.imageName = result.imageName;
            $window.localStorage.setItem("checkChatImageName", 0);
            $scope.checkChatImageName = $window.localStorage.getItem("checkChatImageName");
            socket.getSocket().removeListener("returnFriendList");
            socket.getSocket().removeListener("inbox_id2Header");
            socket.getSocket().removeListener("inbox_id");
            // Inactive send button
            $('#send_btn').attr('disabled','disabled');

            $window.localStorage.setItem("username", $scope.loginId);
            
            // (fromHeader) To check route from index or productDetail page
            if($scope.productTravel == null){
                socket.emit("getUserFriendList", {
                    username: $window.localStorage.getItem("username"), 
                    user_2: "null", 
                    fromHeader: 0,
                    //product_id: 0
                });
            }
            else{
                $scope.offerPrice = $scope.productTravel.amount;
                $window.localStorage.setItem("offer_price", $scope.offerPrice);
                $window.localStorage.setItem("product_id", $scope.productTravel.id);
                socket.emit("getUserFriendList", {
                    username: $window.localStorage.getItem("username"), 
                    user_2: $scope.productTravel.post_travel.profile.loginId, 
                    fromHeader: 0,
                    product_id: $scope.productTravel.id,
                    offer_price: $window.localStorage.getItem("offer_price")
                });   
            }
            
            socket.on('returnFriendList', function (data) {
                $scope.users_temp = data;

                //Get all users inbox id
                angular.forEach($scope.users_temp, function(value, key){
                    console.log("value: " + value + "key: " + key);
                    if (value.user_2 == $window.localStorage.getItem("username")){
                        value.user_2 = value.user_1;
                    }
                    socket.emit("inbox_id", {
                        user_1: $window.localStorage.getItem("username"), 
                        user_2: value.user_2, 
                        fromHeader: 0,
                        product_id: value.post_travel_product_id
                    }); 
                });
                
                var i = 0;
                socket.on('inbox_id2', function(data){
                    socket.emit('get_notification', {inbox_id: data.inbox_id, user_name: data.user_2, name: $window.localStorage.getItem("username")});
                    // $scope.users[data.user_2] = data.inbox_id;
                    // $scope.users[i] = data;
                    listUsers[i] = data;
                    $scope.users[i] = listUsers[i];
                    i++;
                    
                    listUsers.forEach(function (element, index){
                        if($scope.productTravel != null){
                            if($scope.productTravel.post_travel.profile.loginId == element.user_2 && $scope.productTravel.id == element.product_id){
                                $scope.clickOnUserList(element.user_2, element.inbox_id, index);
                            }
                        }
                    });
                });
            });

            // Return notification
            socket.on('notifications_1', function(data){
                if(data.name == $window.localStorage.getItem("username")){
                    $scope.inbox_id[data.inbox_id] = data.count;
                }
            });

            socket.on('notifications', function(data){
                $scope.inbox_id[data.inbox_id] = data.count;

            });
        });
    };

    $scope.postMessage = function () {
        if(angular.isUndefined($scope.user_message)){
            $scope.user_message = '';
        }else if($scope.user_message != "" || $scope.user_message != ''){
            socket.emit('message', {
                name: $scope.loginId, 
                msg: $scope.user_message, 
                frnd_name: $window.localStorage.getItem("frnd_name"),
                inbox_id: $window.localStorage.getItem("inbox_id")
            });
            $scope.user_message = '';
        }
    };

    $scope.clickOnUserList = function (name, id, index){
        $window.localStorage.setItem("frnd_name", name);
        $window.localStorage.setItem("inbox_id", id);
        $scope.friendName = name;
        $scope.messages = [];
        $scope.offerPrice = $scope.users[index].offer_price;
        $scope.indexFromUserList = index;
        $scope.isSold = $scope.users[index].is_sold;

        // Inactive send button
        $('#send_btn').removeAttr('disabled');

        // Get friend's user profile image
        socket.emit('get_friend_profile_image', name);

        // Return friend's user profile image
        socket.on('return_friend_profile_image', function (friendImage) {
            $scope.imageName = friendImage;
            
            if($scope.imageName !== ""){
                $window.localStorage.setItem("checkChatImageName", 1);
            }
            $scope.checkChatImageName = $window.localStorage.getItem("checkChatImageName");
        });

        // Pass inbox_id to db
        socket.emit("get_messages", {inbox_id: $window.localStorage.getItem("inbox_id")});

        // Return inbox messages
        socket.on('all_messages', function(data){
            if(data[0].inbox_id == $window.localStorage.getItem("inbox_id")){
                $scope.messages = data;
            }
        });

        // Read notification
        socket.emit("read_notification", {
            inbox_id: $window.localStorage.getItem("inbox_id"), 
            user_name: $window.localStorage.getItem("frnd_name")
        });

        // Update user read msg in inbox list to 0
        $scope.inbox_id[$window.localStorage.getItem("inbox_id")] = 0;

        // Update notification inbox in home page
        if($scope.inbox_id[$window.localStorage.getItem("inbox_id")] == 0){
            socket.emit('setHomePageCountToZero', {setCount: 0});
        }
    };

    // Update seen notification
    var temp = [''];
    socket.on('seen_notification', function(data){
        temp = data;
        temp.filter(function(item){
            $scope.messages.find(x => x.id == item.id).seen_time = item.seen_time;
        })
    });

    // New message
    socket.on('new_message', function(data){
        if(data.inbox_id == $window.localStorage.getItem("inbox_id")){
            $scope.messages.push({
                user_name:data.user_name,
                Message:data.message,
                time:data.time,
                seen_time:data.seen_time,
                id:data.id
            });
            
            if(data.user_name != $window.localStorage.getItem("username")){
                socket.emit("msg_read", {inbox_id: data.inbox_id, user_name: data.user_name});
            }
        }
        //$scope.messages = [];
    });

    $scope.check_seen = function(name){
        if(name == $window.localStorage.getItem("username")){
            return true;
        }
        else{
            return false;
        }
    };

    $scope.get_count = function(id){
        return $scope.inbox_id[id];
    };

    $scope.makeOffer = function(){
        if(angular.isUndefined($scope.offerPrice)){
            $scope.offerPrice = '';
        }else if($scope.offerPrice != "" || $scope.offerPrice != ''){
            socket.emit('message', {
                name: $scope.loginId, 
                msg: $scope.offerPrice, 
                frnd_name: $window.localStorage.getItem("frnd_name"),
                inbox_id: $window.localStorage.getItem("inbox_id")
            });

            socket.emit('edit_offer_price', {
                inbox_id: $window.localStorage.getItem("inbox_id"),
                offer_price: $scope.offerPrice, 
            });

            // Update offer price in the users list
            var indexFromUserList = $scope.indexFromUserList;
            $scope.users[indexFromUserList].offer_price = $scope.offerPrice;
        }
    };


}]);

