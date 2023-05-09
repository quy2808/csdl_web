$("#tab-user")
	.DataTable({
		// dom: "Bfrtip", //Thêm dom vào thì nó sẽ hiện đồng thời giữa language và bottom
		searching: false,
		ordering: false,
		responsive: true,
		lengthChange: false,
		paging: false,
		autoWidth: false,
		info: false,
		language: {
			url: "//cdn.datatables.net/plug-ins/1.10.25/i18n/Vietnamese.json",
		},
	})


function config() {

	$("#button-add").click(function (e) {
	  
		var name = $("#form-add-user input[name='fname']").val();
		var age = $("#form-add-user input[name='age']").val();
		var CCCD = $("#form-add-user input[name='CCCD']").val();
		var phone = $("#form-add-user input[name='phone']").val();
		var email = $("#form-add-user input[name='email']").val();
		var salary = $("#form-add-user input[name='salary']").val();	  
		var url = $("#fileToUpload").val();
		var length = url.length;
		if(length == 0) {
			url = 'public/img/user/default.png'
		}
		var job = ''
		var gender = ''

		if($("input[name='job']").is(":checked")) {
			job = $("input[name='job']:checked").val();
		}

		if($("input[name='gender']").is(":checked")) {
			gender = $("input[name='gender']:checked").val();
		}
		
		if (name == "" || age == "" || CCCD == "" || phone == "" || email == "" || salary == "" || job == "" || gender == "") {
			$(document).Toasts("create", {
				class: "bg-danger",
				title: "Quản lý",
				subtitle: "Library",
				body: "Bạn phải nhập đầy đủ thông tin",
				closeDuration: 100
			});
		} else {
			if(gender == '0') {
				gender = 'Nam'
			} else {
				gender = 'Nu'
			}
			$.ajax({ 
				method: "POST",       
				url: "index.php?page=admin&controller=user&action=insert",
				data: {'name': name, 'age': age, 'CCCD': String(CCCD), 'phone': phone, 'email': email, 'salary': salary, 'job' : job, 'gender' : gender, 'img_url': url}
			  }).done(function( data ) { 
				var result= JSON.parse(data); 
				if(result != '') {
					$(document).Toasts("create", {
						class: "bg-danger",
						title: "Quản lý",
						subtitle: "Library",
						body: result,
					});
				} else {
					$(document).Toasts("create", {
						class: "bg-success",
						title: "Quản lý",
						subtitle: "Library",
						body: "Thêm nhân viên thành công",
					});

					setTimeout(function () {}, 100)

					if(url != 'public/img/user/default.png'){
						document.getElementById('form-add-user').submit();
					} else {
						location.reload();
					}
				}
		  
			   });
			   
		}
	  
	});

	$(".btn-edit").click(function (e) {
		var email = $(this).data("email");
		var fname = $(this).data("fname");
		var gender = $(this).data("gender");
		var age = $(this).data("age");
		var phone = $(this).data("phone");
		var img = $(this).data("img");
		var cccd = $(this).data("cccd");
		var salary = $(this).data("salary")
		var job = $(this).data("job")
		// console.log(email, fname, lname, gender, age, phone);
		$("#EditUserModal input[name='email']").val(email);
		$("#EditUserModal input[name='fname']").val(fname);
		if (gender === 'Nam')
			$('#EditUserModal #Nam').prop("checked", true); //Search checked input radio jquery
		else
			$('#EditUserModal #Nu').prop("checked", true);
		
		if (job == 'Tài xế') {
			$('#EditUserModal #taixe').prop("checked", true);
		}
	
		if (job == 'Lơ xe') {
			$('#EditUserModal #loxe').prop("checked", true);
		}
	
		if (job == 'Nhân viên biên bản') {
			$('#EditUserModal #bienban').prop("checked", true);
		}
	
		if (job == 'Quản lý') {
			$('#EditUserModal #quanly').prop("checked", true);
		}
	
		$("#EditUserModal input[name='age']").val(age);
		$("#EditUserModal input[name='phone']").val(phone);
		$("#EditUserModal input[name='img']").val(img);
		$("#EditUserModal input[name='CCCD']").val(cccd);
		$("#EditUserModal input[name='salary']").val(salary);
		$('#EditUserModal').modal('show');
	})

	$("#btn-edit").click(function (e) {
	  
		var name = $("#form-edit-user input[name='fname']").val();
		var age = $("#form-edit-user input[name='age']").val();
		var CCCD = $("#form-edit-user input[name='CCCD']").val();
		var phone = $("#form-edit-user input[name='phone']").val();
		var email = $("#form-edit-user input[name='email']").val();
		var salary = $("#form-edit-user input[name='salary']").val();	  
		var url_upload = $("#fileToUpload_edit").val();
		var url = $("#form-edit-user input[name='img']").val();
		var job = ''
		var gender = ''

		if($("input[name='job']").is(":checked")) {
			job = $("input[name='job']:checked").val();
		}

		if($("input[name='gender']").is(":checked")) {
			gender = $("input[name='gender']:checked").val();
		}
		
		if (name == "" || age == "" || CCCD == "" || phone == "" || email == "" || salary == "" || job == "" || gender == "") {
			$(document).Toasts("create", {
				class: "bg-danger",
				title: "Quản lý",
				subtitle: "Library",
				body: "Bạn phải nhập đầy đủ thông tin",
				closeDuration: 100
			});
		} else {
			if(gender == '0') {
				gender = 'Nam'
			} else {
				gender = 'Nu'
			}
			$.ajax({ 
				method: "POST",       
				url: "index.php?page=admin&controller=user&action=update",
				data: {'name': name, 'age': age, 'CCCD': String(CCCD), 'phone': phone, 'email': email, 'salary': salary, 'job' : job, 'gender' : gender, 'img_url': url}
			  }).done(function( data ) { 
				var result= JSON.parse(data); 
				if(result != '') {
					$(document).Toasts("create", {
						class: "bg-danger",
						title: "Quản lý",
						subtitle: "Library",
						body: result,
					});
				} else {
					$(document).Toasts("create", {
						class: "bg-success",
						title: "Quản lý",
						subtitle: "Library",
						body: "Cập nhật nhân viên thành công",
					});

					setTimeout(function () {}, 100)

					if(url_upload.length != 0){
						document.getElementById('form-edit-user').submit();
					} else {
						console.log('done')
						location.reload();
					}
				}
		  
			   });
			   
		}
	  
	});
	
	
	$(".btn-delete").click(function (e) {
		var cccd = $(this).data("cccd");
		var img = $(this).data("img");
		$("#DeleteUserModal input[name='CCCD']").val(cccd);
		$("#DeleteUserModal input[name='img']").val(img);
		$('#DeleteUserModal').modal('show');
	})
}

config()

$("#search_input").on('input', function (e) {
	var selected = $("#job :selected").val()
	var content = $(this).val();
	  $.ajax({ 
		method: "POST",       
		url: "index.php?page=admin&controller=user&action=search",
		data: {'content': content}
	  }).done(function( data ) { 
		var result= JSON.parse(data); 
		$("#tab-user").find('tbody').remove()
		var tbody = '<tbody>'
		result[0].map((data, i) => {
			if( (selected == '0' && result[1][i] == 'Tài xế') || (selected == '1' && result[1][i] == 'Lơ xe') || (selected == '2' && result[1][i] == 'Nhân viên biên bản') || (selected == '3' && result[1][i] == 'Quản lý') || selected == '-1') {
				tbody += 
				"<tr class=\"text-center\">"+
					"<td>" + (i + 1) + "</td>" +
					"<td><img style=\"width: 100px; height:140px; boder-width: 1; border-radius: 50%\" src='" + data.img_url + "'></td>" +
					"<td>" + data.hoten + "</td>" +
					"<td>" + data.gioitinh + "</td>" +
					"<td>" + ( 2022 - data.namsinh) + "</td>" +
					"<td>" + data.mucluong + "</td>" +
					"<td>" + result[1][i] + "</td>" +
					"<td>" +
					"<btn class='btn-edit btn btn-primary btn-xs' style='margin-right: 5px' data-email='" + data.email + "' data-fname='" + data.hoten + "' data-gender='" + data.gioitinh + "' data-age='" + data.namsinh + "' data-phone='" + data.sdt + "' data-img='" + data.img_url + "' data-cccd='" + data.CCCD + "' data-salary='" + data.mucluong + "' data-job='" + result[1][i] + "'> <i class='fas fa-edit'></i></btn>" +
					"<btn class='btn-delete btn btn-danger btn-xs' style='margin-right: 5px' data-cccd='" + data.CCCD + "' data-img='" + data.img_url + "'> <i class='fas fa-trash'></i></btn>" +           
					"</td>" +

				"</tr>"
			}
		})
		tbody += '</tbody>'
		$(tbody).insertAfter("#head_table")
		config()
  
	   }); 
})

$("#job").on('change', function() {
	
	var content = $("#search_input").val();
	var selected = $("#job :selected").val()
	  $.ajax({ 
		method: "POST",       
		url: "index.php?page=admin&controller=user&action=search",
		data: {'content': content}
	  }).done(function( data ) { 
		var result= JSON.parse(data); 
		$("#tab-user").find('tbody').remove()
		var tbody = '<tbody>'
		result[0].map((data, i) => {
			if( (selected == '0' && result[1][i] == 'Tài xế') || (selected == '1' && result[1][i] == 'Lơ xe') || (selected == '2' && result[1][i] == 'Nhân viên biên bản') || (selected == '3' && result[1][i] == 'Quản lý') || selected == '-1') {
				tbody += 
				"<tr class=\"text-center\">"+
					"<td>" + (i + 1) + "</td>" +
					"<td><img style=\"width: 100px; height:140px; boder-width: 1; border-radius: 50%\" src='" + data.img_url + "'></td>" +
					"<td>" + data.hoten + "</td>" +
					"<td>" + data.gioitinh + "</td>" +
					"<td>" + ( 2022 - data.namsinh) + "</td>" +
					"<td>" + data.mucluong + "</td>" +
					"<td>" + result[1][i] + "</td>" +
					"<td>" +
					"<btn class='btn-edit btn btn-primary btn-xs' style='margin-right: 5px' data-email='" + data.email + "' data-fname='" + data.hoten + "' data-gender='" + data.gioitinh + "' data-age='" + data.namsinh + "' data-phone='" + data.sdt + "' data-img='" + data.img_url + "' data-cccd='" + data.CCCD + "' data-salary='" + data.mucluong + "' data-job='" + result[1][i] + "'> <i class='fas fa-edit'></i></btn>" +
					"<btn class='btn-delete btn btn-danger btn-xs' style='margin-right: 5px' data-cccd='" + data.CCCD + "' data-img='" + data.img_url + "'> <i class='fas fa-trash'></i></btn>" +           
					"</td>" +
	
				"</tr>"

			}
		})
		tbody += '</tbody>'
		$(tbody).insertAfter("#head_table")
		config()
  
	   });
})

var sort = 0
$('#sort').on('click', function() {
	if(sort == 0) {
		sort = 'ASC'
	}

	if(sort == 'ASC') {
		sort = 'DESC'
	} else {
		sort = 'ASC'
	}

	var content = $("#search_input").val('');
	var selected = $("#job").val('-1')

	$.ajax({ 
		method: "POST",       
		url: "index.php?page=admin&controller=user&action=order",
		data: {'order': sort}
	  }).done(function( data ) { 
		var result= JSON.parse(data); 
		console.log(result);
		$("#tab-user").find('tbody').remove()
		var tbody = '<tbody>'
		result[0].map((data, i) => {
			tbody += 
				"<tr class=\"text-center\">"+
					"<td>" + (i + 1) + "</td>" +
					"<td><img style=\"width: 100px; height:140px; boder-width: 1; border-radius: 50%\" src='" + data.img_url + "'></td>" +
					"<td>" + data.hoten + "</td>" +
					"<td>" + data.gioitinh + "</td>" +
					"<td>" + ( 2022 - data.namsinh) + "</td>" +
					"<td>" + data.mucluong + "</td>" +
					"<td>" + result[1][i] + "</td>" +
					"<td>" +
					"<btn class='btn-edit btn btn-primary btn-xs' style='margin-right: 5px' data-email='" + data.email + "' data-fname='" + data.hoten + "' data-gender='" + data.gioitinh + "' data-age='" + data.namsinh + "' data-phone='" + data.sdt + "' data-img='" + data.img_url + "' data-cccd='" + data.CCCD + "' data-salary='" + data.mucluong + "' data-job='" + result[1][i] + "'> <i class='fas fa-edit'></i></btn>" +
					"<btn class='btn-delete btn btn-danger btn-xs' style='margin-right: 5px' data-cccd='" + data.CCCD + "' data-img='" + data.img_url + "'> <i class='fas fa-trash'></i></btn>" +           
					"</td>" +
	
				"</tr>"
		})
		tbody += '</tbody>'
		$(tbody).insertAfter("#head_table")
		config()
  
	   });
	
})

