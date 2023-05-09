<?php
	session_start();
	if (!isset($_SESSION["user"])) {
		header("Location: index.php?page=admin&controller=login&action=index");
	}
?>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Web CSDL</title>
	<!-- Google Font: Source Sans Pro-->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&amp;display=fallback">
	<!-- Font Awesome-->
	<link rel="stylesheet" href="public/plugins/fontawesome-free/css/all.min.css">
	<!-- DataTables-->
	<link rel="stylesheet" href="public/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" href="public/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
	<link rel="stylesheet" href="public/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
	<!-- Theme style-->
	<link rel="stylesheet" href="public/dist/css/adminlte.min.css">
	<!-- Add Style -->