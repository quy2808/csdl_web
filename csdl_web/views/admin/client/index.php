
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
                    <h1>Quản lý Khách hàng</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">Quản lý Khách hàng</li>
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
                                        <option value="0">Khách gửi</option>
                                        <option value="1">Khách nhận</option>
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
                                        <form id='form-add-client' action="index.php?page=admin&controller=user&action=add" enctype="multipart/form-data" method="post">
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
                                                            <label>Email</label>
                                                            <input class="form-control" type="text" placeholder="Email" name="email" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Số điện thoại</label>
                                                            <input class="form-control" type="text" placeholder="Số điện thoại" name="phone" />
                                                        </div>
                                                    </div>

                                                </div>


                                                <div class="form-group">
                                                    <label>Địa chỉ</label>
                                                    <input class="form-control" type="text" placeholder="Địa chỉ" name="addr" />
                                                </div>


                                                <div class="row">
                                                    
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Dịch vụ:</label>
                                                            <div class="row" style="width: 400px">
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" name="gui" id='gui' value="0" />
                                                                        <label>Khách gửi</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" name="nhan" id='nhan' value="1" />
                                                                        <label>Khách nhận</label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                                

                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-secondary" type="button" data-dismiss="modal">Đóng lại</button>
                                                <button id="button-add" class="btn btn-primary" type="button">Thêm mới</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <table class="table table-bordered table-striped" id="tab-user">
                                <thead id='head_table'>
                                    <tr class="text-center">
                                        <th>STT</th>
                                        <th>Họ và tên</th>
                                        <th>Tuổi</th>
                                        <th>Địa chỉ</th>
                                        <th>Số điện thoại</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    $index = 1;
                                    $index_job = 0;
                                    while($result_client = $client->fetch_assoc()) {
                                        echo "<tr class='text-center' ; white-space: nowrap;'>";
                                        echo "<td>" . $index++ . "</td>";
                                        echo "<td>" . $result_client["hoten"] . "</td>";
                                        echo "<td>" . ( 2022 - $result_client["namsinh"]) . "</td>";
                                        echo "<td>" . $result_client["Diachi"] . "</td>";
                                        echo "<td>" . $result_client["sdt"] . "</td>";
                                        echo "<td>
											<btn class='btn-edit btn btn-primary btn-xs' style='margin-right: 5px' data-email='" . $result_client["email"] . "' data-fname='" . $result_client["hoten"] . "' data-age='" . $result_client["namsinh"] . "' data-phone='" . $result_client["sdt"] . "' data-addr='" . $result_client["Diachi"] . "'data-gui='" . $job[$index_job][0] . "' data-nhan='" . $job[$index_job][1] . "'data-id='" . $result_client["ID"] . "'> <i class='fas fa-edit'></i></btn>
											<btn class='btn-delete btn btn-danger btn-xs' style='margin-right: 5px' data-id='" . $result_client["ID"]  . "'> <i class='fas fa-trash'></i></btn>
											</td>";
                                        echo "</tr>";
                                        $index_job += 1;
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
                                        <form id='form-edit-client' action="index.php?page=admin&controller=user&action=editInfo" enctype="multipart/form-data" method="post">
                                            <input class="form-control" type="int" placeholder="Năm sinh" name="id" hidden/>
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
                                                            <label>Email</label>
                                                            <input class="form-control" type="text" placeholder="Email" name="email" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Số điện thoại</label>
                                                            <input class="form-control" type="text" placeholder="Số điện thoại" name="phone" />
                                                        </div>
                                                    </div>

                                                </div>

                                                
                                                <div class="form-group">
                                                    <label>Địa chỉ</label>
                                                    <input class="form-control" type="text" placeholder="Địa chỉ" name="addr" />
                                                </div>


                                                <div class="row">
                                                    
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Dịch vụ:</label>
                                                            <div class="row" style="width: 400px">
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" name="gui" id='gui' value="0" />
                                                                        <label>Khách gửi</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox" name="nhan" id='nhan' value="1" />
                                                                        <label>Khách nhận</label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

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
                                        <form action="index.php?page=admin&controller=client&action=delete" method="post">
                                            <div class="modal-body">
                                                <input type="hidden" name="id" />
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
<script src="public/js/client/index.js"></script>
</body>

</html>