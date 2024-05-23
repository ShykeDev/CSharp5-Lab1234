myApp.controller('SearchCtrl', function ($scope, $http) {
    $scope.listSanPham = [];
    $scope.sortType = "";
    $scope.sortType = ""

    const queryString = decodeURIComponent(window.location.search);
    const urlParams = new URLSearchParams(queryString);
    const danhmuc = urlParams.get('danhmuc');
    const name = urlParams.get('name');
    console.log(danhmuc);
    if (danhmuc != null) {
        $http.get("/Home/FindSp?danhmuc=" + danhmuc).then(function (response) {
            $scope.listSanPham = response.data;
            console.log($scope.listSanPham);
        }).catch(function (error) {
            location.href = "/Home/page404";
        });
    }

    if (name != null) {
        $http.get("/Home/FindSp?name=" + name).then(function (response) {
            $scope.listSanPham = response.data;
            console.log($scope.listSanPham);
        }).catch(function (error) {
            location.href = "/Home/page404";
        });
    }

    $scope.formatter = function (money) {
        return money.toLocaleString('vi-VN', {
            style: 'currency',
            currency: 'VND',
        });
    }
});
