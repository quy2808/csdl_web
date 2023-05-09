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

	$(".btn-edit").click(function (e) {
		var giaohang = $(this).data("giaohang");
		var nhan = $(this).data("nhan");
		var gui = $(this).data("gui");
		var hang = $(this).data("hang");
		var gia = $(this).data("gia");
		var nv = $(this).data("nv");
		var ngay = $(this).data("ngay");
		
	
		$("#EditUserModal input[name='giaohang']").val(giaohang);
		$("#EditUserModal input[name='nhan']").val(nhan);
		$("#EditUserModal input[name='gui']").val(gui);
		$("#EditUserModal input[name='hang']").val(hang);
		$("#EditUserModal input[name='gia']").val(gia);
		$("#EditUserModal input[name='nv']").val(nv);
		$("#EditUserModal input[name='ngay']").val(ngay);
		$('#EditUserModal').modal('show');
	})

	
	
	$(".btn-delete").click(function (e) {
		var giaohang = $(this).data("giaohang");
		var nhan = $(this).data("nhan");
		var gui = $(this).data("gui");
		var hang = $(this).data("hang");
		var gia = $(this).data("gia");
		var nv = $(this).data("nv");
		var ngay = $(this).data("ngay");

		var doc = new jsPDF('landscape', '', 'a4')

		doc.addFont("Amiri-Regular.ttf", "Amiri", "normal");
		doc.setFont("Amiri");

		doc.setFontSize(25);
		doc.text('HCMUT CSE',20, 20)
		doc.setFontSize(15);
		doc.text('Di An, Binh Duong',20, 30)

		doc.setFontSize(40);
		doc.text('INVOICE',120, 40)

		doc.setFontSize(20);
		doc.text('RECORDING STAFF:     ' + nv, 20, 60)
		doc.text('DAY:     ' + ngay, 20, 70)
		doc.text('SENDER:     ' + gui, 20, 80)
		doc.text('RECEIVER:  ' + nhan, 20, 90)
		doc.text('ROUTES:     ' + giaohang, 20, 100)
		doc.text('PRICE:     ' + gia, 20, 110)
		doc.text('PRODUCT:     ' + hang, 20, 120)

		doc.setFontSize(25);
		doc.text('Receiver',220, 140)
		doc.setFontSize(20);
		doc.text('(signature and full name)',200, 150)

		window.open(doc.output('bloburl'), '_blank')
	})
}

config()

$('#input_year_btn').on('click', function() {
	var year = $('#year').val()

	if(year == '') {
		$(document).Toasts("create", {
			class: "bg-danger",
			title: "Quản lý",
			subtitle: "Library",
			body: "Cần nhập 1 năm hợp lệ!",
		});
	} else {
		$.ajax({
			method: "POST",       
			url: "index.php?page=admin&controller=billsend&action=search",
			data: {'year': year}
		}).done(function( data ) {
			var result = JSON.parse(data);
			$("#tab-user").find('.btn-edit').off();
			$("#tab-user").find('tbody').remove();
			var tbody = '<tbody>'
			result[0].map((data, i) => {
				tbody += 
				"<tr class=\"text-center\">"+
					"<td>" + (i + 1) + "</td>" +
					"<td>" + data.NV_taobienban + "</td>" +
					"<td>" + data.Mucphi + "</td>" +
					"<td>" + data.Nguoi_gui + "</td>" +
					"<td>" + data.Nguoi_nhan + "</td>" +
					"<td>" +
					"<btn class='btn-edit btn btn-primary btn-xs' style='margin-right: 5px' data-nv='" + data.NV_taobienban + "' data-giaohang='" + data.qua_trinh_giao_hang + "' data-gia='" + data.Mucphi + "' data-gui='" + data.Nguoi_gui + "' data-nhan='" + data.Nguoi_nhan + "'data-hang='" + data.Thongtin_hang + "' data-ngay='" + data.Ngaygui + "'> <i class='fas fa-edit'></i></btn>" +
					"<btn class='btn-delete btn btn-danger btn-xs' style='margin-right: 5px' data-nv='" + data.NV_taobienban + "' data-giaohang='" + data.qua_trinh_giao_hang + "' data-gia='" + data.Mucphi + "' data-gui='" + data.Nguoi_gui + "' data-nhan='" + data.Nguoi_nhan + "'data-hang='" + data.Thongtin_hang + "' data-ngay='" + data.Ngaygui + "'> <i class='fas fa-file'></i></btn>" +           
					"</td>" +

				"</tr>";
			})

			tbody += '</tbody>'
			$(tbody).insertAfter("#head_table")
			config()
			if(!result[1]) {
				result[1] = 0
			}
			$('#revenue').html('Doanh thu: ' + result[1])
		})
	}
})



