</head>

<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">
		<!-- Navbar-->
		<nav class="main-header navbar navbar-expand navbar-white navbar-light">
			<!-- Left navbar links-->
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" data-widget="pushmenu" href="index.php" role="button">
						<i class="fas fa-bars"></i>
					</a>
				</li>
				<li class="nav-item d-none d-sm-inline-block">
					<a class="nav-link" href="index.php">Home</a>
				</li>
			</ul>
			<!-- Right navbar links-->
			<ul class="navbar-nav ml-auto">
				<!-- Navbar Search-->
				<li class="nav-item">
					<a class="nav-link" data-widget="fullscreen" href="#" role="button">
						<i class="fas fa-expand-arrows-alt"></i>
					</a>
				</li>
				<li class="nav-item d-none d-sm-inline-block">
					<a class="nav-link" href="index.php?page=admin&controller=login&action=logout">Logout</a>
				</li>
			</ul>
		</nav>
		<!-- /.navbar-->
		<!-- Main Sidebar Container-->
		<aside class="main-sidebar sidebar-dark-primary elevation-4">
			<!-- Brand Logo-->
			<a class="brand-link" href="index.php">
				<img class="brand-image img-circle elevation-3" src="public/dist/img/logo-CSE.png" alt="CSE Logo" style="opacity: .8">
				<span class="brand-text font-weight-light">HCMUT CSE</span>
			</a>
			<!-- Sidebar-->
			<div class="sidebar">
				<!-- Sidebar Menu-->
				<nav class="mt-2">
					<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
						<!--Add icons to the links using the .nav-icon class with font-awesome or any other icon font library -->
						<li class="nav-item">
							<a class="nav-link" href="index.php?page=admin&controller=user&action=index">
								<i class="nav-icon fas fa-user-graduate"> </i>
								<p>Quản lý nhân viên</p>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="index.php?page=admin&controller=client&action=index">
								<i class="nav-icon fas fa-users-cog"></i>
								<p>Quản lý khách hàng</p>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="index.php?page=admin&controller=billsend&action=index">
								<i class="nav-icon fa fa-cube"></i>
								<p>Quản lý Biên bản gửi</p>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="index.php?page=admin&controller=billreceive&action=index">
								<i class="nav-icon fa fa-file"></i>
								<p>Quản lý Biên bản nhận</p>
							</a>
						</li>
					</ul>
					<!-- Content Wrapper. Contains page content-->
				</nav>
			</div>
		</aside>