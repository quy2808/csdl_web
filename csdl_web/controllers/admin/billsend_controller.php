<?php
require_once('controllers/admin/base_controller.php');
require_once('models/billsend.php');


class BillsendController extends BaseController
{
	function __construct()
	{
		$this->folder = 'billsend';
	}

	public function index()
	{
        $billsend = Billsend::getAll();
		
		$billsend_clone = Billsend::getAll();
		$revenue = 0;
		while($check = $billsend_clone->fetch_assoc()) {
			$revenue += $check['Mucphi'];
		}
        $data = array('billsend' => $billsend, 'revenue' => $revenue);
        $this->render('index', $data);
	}

	public function search() {
		$year = $_POST['year'];

		$result = Billsend::getSearchyear($year);       
		$array = array();
        while($row = $result->fetch_assoc()) {
            array_push($array, $row);
        }

		$result_array = array();
		$result_array[] = $array;
		$result_array[] = Billsend::getRevenue($year);

		echo json_encode($result_array);


	}
    
}
