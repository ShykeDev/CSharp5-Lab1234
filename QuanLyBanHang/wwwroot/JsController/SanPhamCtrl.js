
myApp.controller('SanPhamCtrl', function ($scope, $rootScope, $http) {
    $scope.ListSanPham = [];
    $scope.ListDanhMuc = [];
    $scope.ListThuocTinhChung = [];
    $scope.SanPhamModel = {};

    $scope.tmpInput = "";

    $scope.getData = function () {
        $http.get("/SanPhams/ListSanPham2").then(function (response) {
            $scope.ListSanPham = response.data.sanPham;
            $scope.ListDanhMuc = response.data.danhMuc;
            $scope.ListThuocTinhChung = response.data.thuocTinhChung;
            console.log(response.data);
        }).catch(function (error) {
            $scope.getData();
        });
    }
    $scope.getData();

    $scope.OnEditSP = function (item) {
        $("#MainModalLabel").html("Sửa sản phẩm");
        $("#ThemThuocTinh").css("display", "none");
        $("#SuaThuocTinh").css("display", "block");
        $('#MainModal').modal('show');
        $scope.SanPhamModel = item;
    }

    $scope.deleteGiaTriThuocTinh = function (id1, id2) {
        $http.get("/SanPhams/deleteGiaTriThuocTinh?id=" + id2).then(function (response) {
            if (response.data == true) {
                $scope.getData();
                $scope.SanPhamModel.thuocTinhs.find(x => x.id == id1).thuocTinhChung.giaTriThuocTinhs = $scope.SanPhamModel.thuocTinhs.find(x => x.id == id1).thuocTinhChung.giaTriThuocTinhs.filter(function(el) { return el.id != id2; }); 
            } else {
                swal("Oops!", "Đã xảy ra lỗi! Vui lòng thử lại", "error");
            }
        })
    };

    $scope.addThuocTinh = function (tenThuocTinh) {
        console.log(tenThuocTinh);
        $scope.tmpInput = "";
    }

    $scope.AddGiaTriThuocTinh = function (id, giaTri) {
        if (giaTri == "" || giaTri == null) {
            swal("Lỗi!", "vui lòng nhập giá trị!", "error");
            return;
        }
        $.ajax({
            url: '/SanPhams/addGiaTriThuocTinh',
            type: 'post',
            data: {
                id: id,
                giaTri: giaTri
            },
            success: function (response) {
                if (response.success == true) {
                    $scope.getData();
                    const tc = $scope.SanPhamModel.thuocTinhs.find(x => x.id == id);
                    tc.thuocTinhChung.giaTriThuocTinhs.push(response.data);
                    tc.tmpInput = "";
                    console.log(response.data);
                } else {
                    swal("Lỗi!", response.message, "error");
                }
            },
            error: function () {
                swal("Oops!", "Đã xảy ra lỗi!", "error");
                return;
            }
        })
    };

});