<?php
require_once('controllers/admin/base_controller.php');
require_once('models/client.php');

class ClientController extends BaseController
{
    function __construct()
    {
        $this->folder = 'client';
    }

    public function index()
    {
        $client = Client::getAll();
        
        $client_clone = Client::getAll();
        $array_jobs = array();
		while($check = $client_clone->fetch_assoc()) {
			$sub_array = array();
            $sub_array[] = Client::checkKhachgui($check['ID']);
            $sub_array[] = Client::checkKhachnhan($check['ID']);
            array_push($array_jobs, $sub_array);
		}
        $data = array('client' => $client, 'job' => $array_jobs);
		$this->render('index', $data);
    }

    public function insert() {
        $name = $_POST['name'];
        $age = $_POST['age'];
        $addr = $_POST['addr'];
        $email = $_POST['email'];
        $phone = $_POST['phone'];
        $gui = $_POST['gui'];
        $nhan = $_POST['nhan'];

        $result = Client::insert($name, $age, $addr, $phone, $email, $gui, $nhan);

		echo json_encode($result);
    }

    public function update() {
        $id = $_POST['id'];
        $name = $_POST['name'];
        $age = $_POST['age'];
        $addr = $_POST['addr'];
        $email = $_POST['email'];
        $phone = $_POST['phone'];
        $gui = $_POST['gui'];
        $nhan = $_POST['nhan'];

        $result = Client::update($name, $age, $addr, $phone, $email, $gui, $nhan, $id);

		echo json_encode($result);
    }

    public function delete() {
        $ID = $_POST['id'];

        Client::delete($ID);
        header('Location: index.php?page=admin&controller=client&action=index');
    }

    public function search() {
        $content = $_POST['content'];

        $result = Client::getSearch($content);       
		$array = array();
        while($row = $result->fetch_assoc()) {
            array_push($array, $row);
        }


		$result_clone = Client::getSearch($content);
		$array_jobs = array();
		while($check = $result_clone->fetch_assoc()) {
			$sub_array = array();
            $sub_array[] = Client::checkKhachgui($check['ID']);
            $sub_array[] = Client::checkKhachnhan($check['ID']);
            array_push($array_jobs, $sub_array);
		}


		$array_result = array();
		array_push($array_result, $array);
		array_push($array_result, $array_jobs);

        echo json_encode($array_result);
        
    }
}
