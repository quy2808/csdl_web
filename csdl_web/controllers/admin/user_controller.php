<?php
require_once('controllers/admin/base_controller.php');
require_once('models/user.php');

class UserController extends BaseController
{
	function __construct()
	{
		$this->folder = 'user';
	}

	public function index()
	{
		$user = User::getAll();
		$check_user = User::getAll();
		$array_jobs = array();
		while($check = $check_user->fetch_assoc()) {
			if(User::checkLoxe($check['CCCD']) == 1){
				$array_jobs[] = 'Lơ xe';
			}

			if(User::checkTaixe($check['CCCD']) == 1){
				$array_jobs[] = 'Tài xế';
			}

			if(User::checkNvbienban($check['CCCD']) == 1){
				$array_jobs[] = 'Nhân viên biên bản';
			}

			if(User::checkQuanly($check['CCCD']) == 1){
				$array_jobs[] = 'Quản lý';
			}
		}
		$data = array('user' => $user, 'jobs' => $array_jobs);
		$this->render('index', $data);
	}

	public function insert() {
		$name = $_POST['name'];
		$age = $_POST['age']; 
		$CCCD = (string)$_POST['CCCD']; 
		$phone = $_POST['phone']; 
		$email = $_POST['email']; 
		$salary = $_POST['salary']; 
		$job  = $_POST['job']; 
		$gender  = $_POST['gender']; 
		$img_url = $_POST['img_url'];	

		$result = User::insert($name, $age, $CCCD, $phone, $email, $salary, $job, $gender, $img_url);

		echo json_encode($result);
	}

	public function update() {
		$name = $_POST['name'];
		$age = $_POST['age']; 
		$CCCD = (string)$_POST['CCCD']; 
		$phone = $_POST['phone']; 
		$email = $_POST['email']; 
		$salary = $_POST['salary']; 
		$job  = $_POST['job']; 
		$gender  = $_POST['gender']; 
		$img_url = $_POST['img_url'];	

		$result = User::update($name, $age, $CCCD, $phone, $email, $salary, $job, $gender, $img_url);

		echo json_encode($result);
	}

	public function updateImage() {
		$CCCD = $_POST['CCCD'];
		$target_dir = "public/img/user/";
		$path = $_FILES['fileToUpload']['name'];
		$ext = pathinfo($path, PATHINFO_EXTENSION);
		$id = (string)date("Y_m_d_h_i_sa");
		$fileuploadname = (string)$id;
		$fileuploadname .= ".";
		$fileuploadname .= $ext;
		$target_file = $target_dir . basename($fileuploadname);			
		move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file);
		$update = User::updateImage($CCCD, $target_file);
		header('Location: index.php?page=admin&controller=user&action=index');
	}

	public function search() {
        $content = $_POST['content'];
        
		$result = User::getSearch($content);       
		$array = array();
        while($row = $result->fetch_assoc()) {
            array_push($array, $row);
        }


		$result_clone = User::getSearch($content);
		$array_jobs = array();
		while($check = $result_clone->fetch_assoc()) {
			if(User::checkLoxe($check['CCCD']) == 1){
				$array_jobs[] = 'Lơ xe';
			}

			if(User::checkTaixe($check['CCCD']) == 1){
				$array_jobs[] = 'Tài xế';
			}

			if(User::checkNvbienban($check['CCCD']) == 1){
				$array_jobs[] = 'Nhân viên biên bản';
			}

			if(User::checkQuanly($check['CCCD']) == 1){
				$array_jobs[] = 'Quản lý';
			}
		}


		$array_result = array();
		array_push($array_result, $array);
		array_push($array_result, $array_jobs);

        echo json_encode($array_result);
    }

	public function delete()
	{
		$CCCD = $_POST['CCCD'];
		$img = $_POST['img'];
		unlink($img);
		User::delete($CCCD);
		header('Location: index.php?page=admin&controller=user&action=index');
	}

	public function order() {
		$order = $_POST['order'];

		if($order == 'ASC') {
			$result = User::getOrderASC(); 
		} else {
			$result = User::getOrderDESC();
		}
        
		      
		$array = array();
        while($row = $result->fetch_assoc()) {
            array_push($array, $row);
        }

		if($order == 'ASC') {
			$result_clone = User::getOrderASC(); 
		} else {
			$result_clone = User::getOrderDESC();
		}
		
		$array_jobs = array();
		while($check = $result_clone->fetch_assoc()) {
			if(User::checkLoxe($check['CCCD']) == 1){
				$array_jobs[] = 'Lơ xe';
			}

			if(User::checkTaixe($check['CCCD']) == 1){
				$array_jobs[] = 'Tài xế';
			}

			if(User::checkNvbienban($check['CCCD']) == 1){
				$array_jobs[] = 'Nhân viên biên bản';
			}

			if(User::checkQuanly($check['CCCD']) == 1){
				$array_jobs[] = 'Quản lý';
			}
		}


		$array_result = array();
		array_push($array_result, $array);
		array_push($array_result, $array_jobs);

        echo json_encode($array_result);
	}

}