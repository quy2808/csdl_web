
<?php
require_once('views/admin/header.php'); ?>

<!-- Add CSS -->


<?php
require_once('views/admin/content_layouts.php'); ?>


<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-8">
					<h1>Bạn đã đăng nhập vào khu vực Quản trị của HCMUT CSE!</h1>
				</div>
				<div class="col-sm-4">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#">Home</a></li>
						<li class="breadcrumb-item active">Widgets</li>
					</ol>
				</div>
			</div>
		</div><!-- /.container-fluid -->
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="container-fluid">
			<div class="invoice p-3 mb-3">
				<div class="row invoice-info">
					<div class="col-sm-6 invoice-col">
						<ul style="list-style: none;">
							<li><a href="index.php?page=admin&controller=user&action=index" class="fas fa-user-graduate"> Quản lý nhân viên</a></li>
							<li><a href="index.php?page=admin&controller=client&action=index" class="fas fa-users-cog"> Quản lý khách hàng</a></li>
						</ul>
					</div>
					<!-- /.col -->
					<div class="col-sm-6 invoice-col">
						<ul style="list-style: none;">
							<li><a href="index.php?page=admin&controller=billsend&action=index" class="fas fa-cube"> Quản lý biên bản gửi</a></li>
							<li><a href="index.php?page=admin&controller=billreceive&action=index" class="fas fa-file"> Quản lý biên bản nhận</a></li>
						</ul>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<div class="card card-success">
				<div class="card-body">
					<div class="row">
						<div class="col-md-12 col-lg-6 col-xl-4">
							<div class="card mb-2 bg-gradient-dark">
								<img class="card-img-top" src="public/img/layouts/Homepage_1.jpg" alt="Dist Photo 1">
							</div>
						</div>

						<div class="col-md-12 col-lg-6 col-xl-4">
							<div class="card mb-2 bg-gradient-dark">
								<img class="card-img-top" src="public/img/layouts/Homepage_2.jpg" alt="Dist Photo 1">
							</div>
						</div>

						<div class="col-md-12 col-lg-6 col-xl-4">
							<div class="card mb-2 bg-gradient-dark">
								<img class="card-img-top" src="public/img/layouts/Homepage_3.jpg" alt="Dist Photo 1">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div><!-- /.container-fluid -->
	</section>
	<!-- /.content -->
</div>
<?php
require_once('views/admin/footer.php'); ?>

<!-- Add Javascripts -->


</body>

</html>