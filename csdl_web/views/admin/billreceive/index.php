
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
                    <h1>Quản lý biên bản nhận</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">Quản lý biên bản nhận</li>
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
                            <div class='header_card' style="display: grid; grid-template-columns: 20% 80%; margin-bottom: 10px">
                                <div style="display: flex; justify-content: start; align-items: center">                            
                                    
                                </div>
                                <div class='search' style="display: flex; justify-content: end; align-items: center">
                                    <label style="margin-right: 10px">Filter: </label>
                                    <select id="job" value='-1'>
                                        <option value="-1" selected>All</option>
                                        <option value="Nhan tai kho">Nhận tại kho</option>
                                        <option value="Nhan tai nha">Nhận tại nhà</option>
                                    </select>
                                </div>
                            </div>
                            

                            <table class="table table-bordered table-striped" id="tab-user">
                                <thead id='head_table'>
                                    <tr class="text-center">
                                        <th>STT</th>
                                        <th>Nhân viên tạo biên bản</th>
                                        <th>Mức phí</th>
                                        <th>Người gửi</th>
                                        <th>Người nhận</th>
                                        <th>Hình thức nhận hàng</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    $index = 1;
                                    while($result_bill = $billreceive->fetch_assoc()) {
                                        echo "<tr class='text-center' ; white-space: nowrap;'>";
                                        echo "<td>" . $index++ . "</td>";
                                        echo "<td>" . $result_bill["NV_taobienban"] . "</td>";
                                        echo "<td>" . $result_bill["Mucphi"] . "</td>";
                                        echo "<td>" . $result_bill["Nguoi_gui"] . "</td>";
                                        echo "<td>" . $result_bill["Nguoi_nhan"] . "</td>";
                                        echo "<td>" . $result_bill["Hinhthuc_nhanhang"] . "</td>";
                                        echo "<td>
											<btn class='btn-edit btn btn-primary btn-xs' style='margin-right: 5px' data-nv='" . $result_bill["NV_taobienban"] . "' data-giaohang='" . $result_bill["qua_trinh_giao_hang"] . "' data-gia='" . $result_bill["Mucphi"] . "' data-gui='" . $result_bill["Nguoi_gui"] . "' data-nhan='" . $result_bill["Nguoi_nhan"] . "'data-hang='" . $result_bill['Thongtin_hang'] . "' data-ngay='" . $result_bill['Ngaynhan'] . "' data-nhanhang='" . $result_bill["Hinhthuc_nhanhang"] . "'> <i class='fas fa-edit'></i></btn>
											<btn class='btn-delete btn btn-danger btn-xs' style='margin-right: 5px' data-nv='" . $result_bill["NV_taobienban"] . "' data-giaohang='" . $result_bill["qua_trinh_giao_hang"] . "' data-gia='" . $result_bill["Mucphi"] . "' data-gui='" . $result_bill["Nguoi_gui"] . "' data-nhan='" . $result_bill["Nguoi_nhan"] . "'data-hang='" . $result_bill['Thongtin_hang'] . "' data-ngay='" . $result_bill['Ngaynhan'] . "' data-nhanhang='" . $result_bill["Hinhthuc_nhanhang"] . "'> <i class='fas fa-file'></i></btn>
											</td>";
                                        echo "</tr>";
                                    }
                                    ?>
                                </tbody>
                            </table>

                            <div class="modal fade" id="EditUserModal" tabindex="-1" role="dialog" aria-labelledby="EditUserModal" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Thông tin chi tiết</h5>
                                            <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        </div>
                                        <form action="index.php?page=admin&controller=user&action=editInfo" enctype="multipart/form-data" method="post">
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Nhân viên tạo biên bản</label>
                                                            <input class="form-control" type="text" placeholder="Nhân viên tạo biên bản" name="nv" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Ngày gửi</label>
                                                            <input class="form-control" type="text" placeholder="Ngày gửi" name="ngay" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Mức phí</label>
                                                            <input class="form-control" type="text" placeholder="Mức phí" name="gia" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Thông tin hàng</label>
                                                            <input class="form-control" type="text" placeholder="Thông tin hàng" name="hang" />
                                                        </div>
                                                    </div>

                                                </div>

                                                
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Người gửi</label>
                                                            <input class="form-control" type="text" placeholder="Người gửi" name="gui" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>Người nhận</label>
                                                            <input class="form-control" type="text" placeholder="Người nhận" name="nhan" />
                                                        </div>
                                                    </div>

                                                </div>

                                                
                                                <div class="form-group">
                                                    <label>Quá trình giao hàng</label>
                                                    <input class="form-control" type="text" placeholder="Quá trình giao hàng" name="giaohang" />
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label>Hình thức nhận hàng</label>
                                                    <input class="form-control" type="text" placeholder="HÌnh thức nhận hàng" name="nhanhang" />
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-secondary" type="button" data-dismiss="modal">Đóng lại</button>
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
                                                <input type="hidden" name="cccd" />
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
<script src="public/js/billreceive/index.js"></script>
</body>

</html>