<?php
require_once('controllers/admin/base_controller.php');
require_once('models/billreceive.php');


class BillreceiveController extends BaseController
{
	function __construct()
	{
		$this->folder = 'billreceive';
	}

	public function index()
	{
        $billreceive = Billreceive::getAll();
        $data = array('billreceive' => $billreceive);
        $this->render('index', $data);
	}

	public function search() {
		$type = $_POST['type'];

		$result = Billreceive::getSearchtype($type);       
		$array = array();
        while($row = $result->fetch_assoc()) {
            array_push($array, $row);
        }

		echo json_encode($array);


	}
    
}
