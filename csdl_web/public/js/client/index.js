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
	  
		var name = $("#form-add-client input[name='fname']").val();
		var age = $("#form-add-client input[name='age']").val();
		var phone = $("#form-add-client input[name='phone']").val();
		var email = $("#form-add-client input[name='email']").val();	 
        var addr = $("#form-add-client input[name='addr']").val(); 
		
        var gui = 0
		var nhan = 0

		if($("input[name='gui']").is(":checked")) {
			gui = 1
		}
        else {
            gui = 0
        }

		if($("input[name='nhan']").is(":checked")) {
			nhan = 1
		}
        else {
            nhan = 0
        }

		
		if (name == "" || age == "" || phone == "" || addr == "" || email == "" || (gui == 0 && nhan ==0)) {
			$(document).Toasts("create", {
				class: "bg-danger",
				title: "Quản lý",
				subtitle: "Library",
				body: "Bạn phải nhập đầy đủ thông tin",
				closeDuration: 100
			});
		} else {
			$.ajax({ 
				method: "POST",       
				url: "index.php?page=admin&controller=client&action=insert",
				data: {'name': name, 'phone': phone, 'email': email, 'addr' : addr, 'age' : age, 'gui': gui, 'nhan': nhan}
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
						body: "Thêm khách hàng thành công",
					});

					setTimeout(function () {}, 100)

					location.reload()
				}
		  
			   });
			   
		}
	  
	});

	$(".btn-edit").click(function (e) {
		console.log('call')
		var email = $(this).data("email");
		var name = $(this).data("fname");
		var age = $(this).data("age");
		var phone = $(this).data("phone");
		var addr = $(this).data("addr")
        var gui = $(this).data("gui")
        var nhan = $(this).data("nhan")
        var id = $(this).data("id")

        if(gui == 1) {
            $('#EditUserModal #gui').prop("checked", true);
        } else {
            $('#EditUserModal #gui').prop("checked", false);
        }

        if(nhan == 1) {
            $('#EditUserModal #nhan').prop("checked", true);
        } else {
            $('#EditUserModal #nhan').prop("checked", false);
        }
		// console.log(email, fname, lname, gender, age, phone);
        $("#EditUserModal input[name='id']").val(id);
		$("#EditUserModal input[name='email']").val(email);
		$("#EditUserModal input[name='fname']").val(name);	
		$("#EditUserModal input[name='age']").val(age);
		$("#EditUserModal input[name='phone']").val(phone);
        $("#EditUserModal input[name='addr']").val(addr);
		$('#EditUserModal').modal('show');
	})

	$("#btn-edit").click(function (e) {
	  
		var id = $("#form-edit-client input[name='id']").val();	 	
        var name = $("#form-edit-client input[name='fname']").val();
		var age = $("#form-edit-client input[name='age']").val();
		var phone = $("#form-edit-client input[name='phone']").val();
		var email = $("#form-edit-client input[name='email']").val();	 
        var addr = $("#form-edit-client input[name='addr']").val(); 
		console.log(id,email);
		
        var gui = 0
		var nhan = 0

		if($("input[name='gui']").is(":checked")) {
			gui = 1
		}
        else {
            gui = 0
        }

		if($("input[name='nhan']").is(":checked")) {
			nhan = 1
		}
        else {
            nhan = 0
        }

		
		if (name == "" || age == "" || phone == "" || addr == "" || email == "" || (gui == 0 && nhan ==0)) {
			$(document).Toasts("create", {
				class: "bg-danger",
				title: "Quản lý",
				subtitle: "Library",
				body: "Bạn phải nhập đầy đủ thông tin",
				closeDuration: 100
			});
		} else {
			$.ajax({ 
				method: "POST",       
				url: "index.php?page=admin&controller=client&action=update",
				data: {'name': name, 'phone': phone, 'email': email, 'addr' : addr, 'age' : age, 'gui': gui, 'nhan': nhan, 'id': id}
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
						body: "Cập nhật khách hàng thành công",
					});

					setTimeout(function () {}, 100)

					location.reload()
				}
		  
			   });
			   
		}
	  
	});
	
	
	$(".btn-delete").click(function (e) {
		var id = $(this).data("id");
		$("#DeleteUserModal input[name='id']").val(id);
		$('#DeleteUserModal').modal('show');
	})
}

config()

$("#search_input").on('input', function (e) {
	var content = $(this).val();
	var selected = $("#job :selected").val()
	  $.ajax({ 
		method: "POST",       
		url: "index.php?page=admin&controller=client&action=search",
		data: {'content': content}
	  }).done(function( data ) { 
		var result= JSON.parse(data); 
		$("#tab-user").find('.btn-edit').off();
		$("#tab-user").find('tbody').remove();
		var tbody = '<tbody>'
		result[0].map((data, i) => {
			if((selected == '0' && result[1][i][0] == '1') || (selected == '1' && result[1][i][1] == '1') || (selected == '-1')) {
				tbody += 
				"<tr class=\"text-center\">"+
					"<td>" + (i + 1) + "</td>" +
					"<td>" + data.hoten + "</td>" +
					"<td>" + ( 2022 - data.namsinh) + "</td>" +
					"<td>" + data.Diachi + "</td>" +
					"<td>" + data.sdt + "</td>" +
					"<td>" +
					"<btn class='btn-edit btn btn-primary btn-xs' style='margin-right: 5px' data-email='" + data.email + "' data-fname='" + data.hoten + "' data-age='" + data.namsinh + "' data-phone='" + data.sdt + "' data-addr='" + data.Diachi + "'data-gui='" + result[1][i][0] + "' data-nhan='" + result[1][i][1] + "'data-id='" + data.ID + "'> <i class='fas fa-edit'></i></btn>" +
					"<btn class='btn-delete btn btn-danger btn-xs' style='margin-right: 5px' data-id='" + data.ID + "'> <i class='fas fa-trash'></i></btn>" +           
					"</td>" +

				"</tr>"
			}
		})
		tbody += '</tbody>'
		$(tbody).insertAfter("#head_table")
		config()
  
	   }); 
})

$("#job").on('change', function (e) {
	var content = $("#search_input").val();
	var selected = $("#job :selected").val()
	console.log(selected)
	  $.ajax({ 
		method: "POST",       
		url: "index.php?page=admin&controller=client&action=search",
		data: {'content': content}
	  }).done(function( data ) { 
		var result= JSON.parse(data); 
		$("#tab-user").find('.btn-edit').off();
		$("#tab-user").find('tbody').remove();
		var tbody = '<tbody>'
		result[0].map((data, i) => {
			if((selected == '0' && result[1][i][0] == '1') || (selected == '1' && result[1][i][1] == '1') || (selected == '-1')) {
				tbody += 
				"<tr class=\"text-center\">"+
					"<td>" + (i + 1) + "</td>" +
					"<td>" + data.hoten + "</td>" +
					"<td>" + ( 2022 - data.namsinh) + "</td>" +
					"<td>" + data.Diachi + "</td>" +
					"<td>" + data.sdt + "</td>" +
					"<td>" +
					"<btn class='btn-edit btn btn-primary btn-xs' style='margin-right: 5px' data-email='" + data.email + "' data-fname='" + data.hoten + "' data-age='" + data.namsinh + "' data-phone='" + data.sdt + "' data-addr='" + data.Diachi + "'data-gui='" + result[1][i][0] + "' data-nhan='" + result[1][i][1] + "'data-id='" + data.ID + "'> <i class='fas fa-edit'></i></btn>" +
					"<btn class='btn-delete btn btn-danger btn-xs' style='margin-right: 5px' data-id='" + data.ID + "'> <i class='fas fa-trash'></i></btn>" +           
					"</td>" +

				"</tr>"
			}
		})
		tbody += '</tbody>'
		$(tbody).insertAfter("#head_table")
		config()
  
	   }); 
})

