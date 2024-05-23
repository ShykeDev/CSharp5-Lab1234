myApp.controller('DanhMucCtrl', function ($scope, $http) {
    $scope.DanhMucs = [];
    $scope.loadDanhMucs = function () {
        $http.get("/DanhMucs/GetDanhMuc").then(function (response) {
            $scope.DanhMucs = response.data;
        }).catch(function (error) {
            swal("Oops!", "Đã xảy ra lỗi!", "error");
        });
    };
    $scope.loadDanhMucs();
});
