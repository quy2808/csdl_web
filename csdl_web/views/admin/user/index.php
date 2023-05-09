
<?php
require_once('views/admin/header.php'); ?>

<!-- Add CSS -->


<?php
require_once('views/admin/content_layouts.php'); ?>

<!-- Code -->
<div class="content-wrapper">
    <!-- Add Content -->
    <!-- Content Header (Page header)-->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Quản lý Nhân viên</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">Quản lý Nhân viên</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid-->
    </section>
    <!-- Main content-->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <!-- Button trigger modal-->
                            <div class='header_card' style="display: grid; grid-template-columns: 20% 50% 30%; margin-bottom: 10px">
                                <div style="display: flex; justify-content: start; align-items: center">                            
                                    <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#addUserModal">Thêm mới</button>
                                </div>
                                <div class='search' style="display: flex; justify-content: end; align-items: center">
                                    <label style="margin-right: 10px">Filter: </label>
                                    <select id="job" value='-1'>
                                        <option value="-1" selected>All</option>
                                        <option value="0">Tài xế</option>
                                        <option value="1">Lơ xe</option>
                                        <option value="2">Nhân viên biên bản</option>
                                        <option value="3">Quản lý</option>
                                    </select>
                                </div>
                                <div class='search' style="display: flex; justify-content: end; align-items: center">
                                    <label style="margin-right: 10px">Tìm: </label>
                                    <input type="text" id='search_input'>
                                </div>
                            </div>
                            <!-- Modal-->
                            <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="addUserModal" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Thêm mới</h5>
                                            <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        </div>
                                        <form id='form-add-user' action="index.php?page=admin&controller=user&action=updateImage" enctype="multipart/form-data" method="POST">
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Họ và tên</label>
                                                            <input class="form-control" type="text" placeholder="Họ và tên lót" name="fname" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Năm sinh</label>
                                                            <input class="form-control" type="text" placeholder="Năm sinh" name="age" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>CCCD</label>
                                                            <input class="form-control" type="text" placeholder="CCCD" name="CCCD" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Số điện thoại</label>
                                                            <input class="form-control" type="text" placeholder="Số điện thoại" name="phone" />
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Email</label>
                                                            <input class="form-control" type="text" placeholder="Email" name="email" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Lương</label>
                                                            <input class="form-control" type="text" placeholder="Lương" name="salary" />
                                                        </div>
                                                    </div>

                                                </div>
                                                
                                                <div class="form-group">
                                                    <label>Công việc:</label>
                                                    <div style="display: flex; justify-content: space-between">
                                                    <div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" id='taixe' type="radio" name="job" value="0" />
                                                                <label>Tài xế</label>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" id='loxe' type="radio" name="job" value="1" />
                                                                <label>Lơ xe</label>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" id='bienban' type="radio" name="job" value="2" />
                                                                <label>Nhân viên biên bản</label>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" id='quanly' type="radio" name="job" value="3" />
                                                                <label >Quản lý</label>                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>                                              

                                                <div class="row">
                                                    
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Giới tính:</label>
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="radio" name="gender" id='Nam' value="0" />
                                                                        <label>Nam</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="radio" name="gender" id='Nu' value="1" />
                                                                        <label>Nữ</label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="form-group">
                                                    <label>Hình ảnh</label>&nbsp
                                                    <input type="file" name="fileToUpload" id="fileToUpload" />
                                                </div>

                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-secondary" type="button" data-dismiss="modal">Đóng lại</button>
                                                <button id='button-add' class="btn btn-primary" type="button">Thêm mới</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <table class="table table-bordered table-striped" id="tab-user">
                                <thead id='head_table'>
                                    <tr class="text-center">
                                        <th>STT</th>
                                        <th>Hình ảnh</th>
                                        <th>Họ và tên</th>
                                        <th>Giới tính</th>
                                        <th>Tuổi</th>
                                        <th>Lương <i id='sort' style='margin-left: 4px; font-size:13px; cursor: pointer;' class="nav-icon fa fa-angle-double-down"></i></th>
                                        <th>Công việc</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    $index = 1;
                                    $index_jobs = 0;
                                    while($result_user = $user->fetch_assoc()) {
                                        echo "<tr class='text-center' ; white-space: nowrap;'>";
                                        echo "<td>" . $index++ . "</td>";
                                        echo "<td><img style=\"width: 100px; height:140px; boder-width: 1; border-radius: 50%\" src='" . $result_user["img_url"] . "'></td>";
                                        echo "<td>" . $result_user["hoten"] . "</td>";
                                        echo "<td>" . $result_user["gioitinh"] . "</td>";
                                        echo "<td>" . ( 2022 - $result_user["namsinh"]) . "</td>";
                                        echo "<td>" . $result_user["mucluong"] . "</td>";
                                        echo "<td>" . $jobs[$index_jobs] . "</td>";
                                        echo "<td>
											<btn class='btn-edit btn btn-primary btn-xs' style='margin-right: 5px' data-email='" . $result_user["email"] . "' data-fname='" . $result_user["hoten"] . "' data-gender='" . $result_user["gioitinh"] . "' data-age='" . $result_user["namsinh"] . "' data-phone='" . $result_user["sdt"] . "' data-img='" . $result_user["img_url"] . "' data-cccd='" . $result_user["CCCD"] . "' data-salary='" . $result_user["mucluong"] . "' data-job='" . $jobs[$index_jobs] . "'> <i class='fas fa-edit'></i></btn>
											<btn class='btn-delete btn btn-danger btn-xs' style='margin-right: 5px' data-cccd='" . $result_user["CCCD"] . "' data-img='" . $result_user["img_url"] . "'> <i class='fas fa-trash'></i></btn>
											</td>";
                                        echo "</tr>";
                                        $index_jobs += 1;
                                    }
                                    ?>
                                </tbody>
                            </table>

                            <div class="modal fade" id="EditUserModal" tabindex="-1" role="dialog" aria-labelledby="EditUserModal" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Chỉnh sửa</h5>
                                            <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        </div>
                                        <form id='form-edit-user' action="index.php?page=admin&controller=user&action=updateImage" enctype="multipart/form-data" method="post">
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Họ và tên</label>
                                                            <input class="form-control" type="text" placeholder="Họ và tên lót" name="fname" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Năm sinh</label>
                                                            <input class="form-control" type="number" placeholder="Năm sinh" name="age" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>CCCD</label>
                                                            <input class="form-control" type="number" placeholder="CCCD" name="CCCD" readonly/>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Số điện thoại</label>
                                                            <input class="form-control" type="number" placeholder="Số điện thoại" name="phone" />
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Email</label>
                                                            <input class="form-control" type="text" placeholder="Email" name="email" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Lương</label>
                                                            <input class="form-control" type="text" placeholder="Lương" name="salary" />
                                                        </div>
                                                    </div>

                                                </div>
                                                
                                                <div class="form-group">
                                                    <label>Công việc:</label>
                                                    <div style="display: flex; justify-content: space-between">
                                                        <div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" id='taixe' type="radio" name="job" value="0" />
                                                                <label>Tài xế</label>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" id='loxe' type="radio" name="job" value="1" />
                                                                <label>Lơ xe</label>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" id='bienban' type="radio" name="job" value="2" />
                                                                <label>Nhân viên biên bản</label>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" id='quanly' type="radio" name="job" value="3" />
                                                                <label >Quản lý</label>                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>                                              

                                                <div class="row">
                                                    
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Giới tính:</label>
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="radio" name="gender" id='Nam' value="0" />
                                                                        <label>Nam</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="radio" name="gender" id='Nu' value="1" />
                                                                        <label>Nữ</label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="form-group">
                                                    <label>Hình ảnh hiện tại </label>
                                                    <input class="form-control" type="text" name="img" disabled/>
                                                </div>
                                                <div class="form-group">
                                                    <label>Hình ảnh mới</label>&nbsp
                                                    <input type="file" name="fileToUpload" id="fileToUpload_edit" />
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-secondary" type="button" data-dismiss="modal">Đóng lại</button>
                                                <button id='btn-edit' class="btn btn-primary" type="button">Cập nhật</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="modal fade" id="DeleteUserModal" tabindex="-1" role="dialog" aria-labelledby="DeleteUserModal" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content bg-danger">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Xóa</h5>
                                            <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        </div>
                                        <form action="index.php?page=admin&controller=user&action=delete" method="post">
                                            <div class="modal-body">
                                                <input type="hidden" name="CCCD" />
                                                <input type="hidden" name="img" />
                                                <p>Bạn chắc chưa ?</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-danger btn-outline-light" type="button" data-dismiss="modal">Đóng lại</button>
                                                <button class="btn btn-danger btn-outline-light" type="submit">Xác nhận</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </section>
</div>


<?php
require_once('views/admin/footer.php'); ?>

<!-- Add Javascripts -->
<script src="public/js/user/index.js"></script>
</body>

</html>