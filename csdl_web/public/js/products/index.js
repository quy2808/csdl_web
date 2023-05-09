$("#TAB-product")
  .DataTable({
    searching: false,
    info: false,
    responsive: true,
    lengthChange: false,
    autoWidth: false,
    ordering: false,
    language: {
      url: "//cdn.datatables.net/plug-ins/1.10.25/i18n/Vietnamese.json",
    },
  })
  .buttons()
  .container()
  .appendTo("#TAB-product_wrapper .col-md-6:eq(0)");

$("#form-add-student").submit(function (e) {
  e.preventDefault();

  //Write code to check if student id is existed!
  //Camel case
  var name = $("#form-add-student input[name='name']").val();
  var price = $("#form-add-student input[name='price']").val();
  var description = $("#form-add-student textarea[name='description']").val();
  var content = $("#form-add-student textarea[name='content']").val();

  var url = $("#fileToUpload").val();
  var length = url.length;
  var form = $(this);
  var a = url[length - 1];
  var b = url[length - 2];
  var c = url[length - 3];
  var ext = c + b + a;
  if (name == "" || description == "" || content == "" || url == "") {
    $(document).Toasts("show", {
      class: "bg-danger",
      title: "Quản lý",
      subtitle: "Library",
      body: "Bạn phải nhập đầy đủ thông tin",
      hideAfter: 100,
    });
  } else {
    if (price < 1000) {
      $(document).Toasts("create", {
        class: "bg-danger",
        title: "Quản lý",
        subtitle: "Library",
        body: "Bạn phải nhập giá lớn hơn 1000 đồng",
      });
    } else {
      if (ext == "jpg" || ext == "png" || ext == "jpeg" || ext == "gif") {
        $(document).Toasts("create", {
          class: "bg-success",
          title: "Quản lý",
          subtitle: "Library",
          body: "Bạn Thêm mới thành công",
        });
        form.unbind("submit").submit();
        setTimeout(function () {
        }, 1000);
      } else {
        $(document).Toasts("create", {
          class: "bg-danger",
          title: "Quản lý",
          subtitle: "Library",
          body: "Bạn phải gửi file định dạng ảnh",
        });
      }
    }
  }

});


$(".btn-edit").click(function (e) {
  var id = $(this).data("id");
  var name = $(this).data("name");
  var price = $(this).data("price");
  var description = $(this).data("description");
  var content = $(this).data("content");
//   console.log(content);
  $("#EditStudentModal input[name='id']").val(id);
  $("#EditStudentModal input[name='name']").val(name);
  $("#EditStudentModal input[name='price']").val(price);
  $("#EditStudentModal textarea[name='description']").val(description);
  $("#EditStudentModal textarea[name='content']").val(content);
  $("#EditStudentModal").modal("show");
});

$(".btn-delete").click(function (e) {
  var id = $(this).data("id");
  $("#DeleteStudentModal input[name='id']").val(id);
  $("#DeleteStudentModal").modal("show");
});




$("#search_input").on('input', function (e) {
  content = $(this).val();
    $.ajax({ 
      method: "POST",       
      url: "index.php?page=admin&controller=products&action=search",
      data: {'content': content}
    }).done(function( data ) { 
      var result= JSON.parse(data); 
      $("#TAB-product").find('tbody').remove()
      var tbody = '<tbody>'
      result.map((data, i) => {
        tbody += 
        "<tr class=\"text-center\">"+
            "<td>" + (i + 1) + "</td>" +
            "<td>" + data.name + "</td>" +
            "<td>" + data.price + "</td>" +
            "<td>" + data.description + "</td>" +
            "<td>" + data.content + "</td>" +
            "<td>" +
              "<button class=\"btn-edit btn btn-primary btn-xs\" style=\"margin-right: 5px\" data-id='" + data.id + "' data-name='" + data.name+ "' data-price='" + data.price + "' data-description='" + data.description + "' data-content='" + data.content + "'> <i style=\"font-size:17px;\" class=\"fas fa-edit\" ></i></button>" +
              "<button class=\"btn-delete btn btn-danger btn-xs\" style=\"margin-right: 5px\" data-id='" + data.id + "' ><i style=\"font-size:17px;\" class=\"fas fa-trash\"></i></button>" +           
            "</td>" +

        "</tr>"
      })
      tbody += '</tbody>'
      $(tbody).insertAfter("#head_table")

      $(".btn-delete").click(function (e) {
        var id = $(this).data("id");
        $("#DeleteStudentModal input[name='id']").val(id);
        $("#DeleteStudentModal").modal("show");
      });

      $(".btn-edit").click(function (e) {
        var id = $(this).data("id");
        var name = $(this).data("name");
        var price = $(this).data("price");
        var description = $(this).data("description");
        var content = $(this).data("content");
      //   console.log(content);
        $("#EditStudentModal input[name='id']").val(id);
        $("#EditStudentModal input[name='name']").val(name);
        $("#EditStudentModal input[name='price']").val(price);
        $("#EditStudentModal textarea[name='description']").val(description);
        $("#EditStudentModal textarea[name='content']").val(content);
        $("#EditStudentModal").modal("show");
      });

     }); 
})

var ordering = 'ASC'

$("#ordering").on("click", function (e) {
  e.preventDefault()
  if(ordering == 'ASC') {
    ordering = 'DESC'
  } else {
    ordering = 'ASC'
  }

  $.ajax({ 
    method: "POST",       
    url: "index.php?page=admin&controller=products&action=order",
    data: {'type': ordering}
  }).done(function( data ) { 
    var result= JSON.parse(data); 
    $("#TAB-product").find('tbody').remove()
    var tbody = '<tbody>'
    result.map((data, i) => {
      tbody += 
      "<tr class=\"text-center\">"+
          "<td>" + (i + 1) + "</td>" +
          "<td>" + data.name + "</td>" +
          "<td>" + data.price + "</td>" +
          "<td>" + data.description + "</td>" +
          "<td>" + data.content + "</td>" +
          "<td>" +
            "<button class=\"btn-edit btn btn-primary btn-xs\" style=\"margin-right: 5px\" data-id=" + data.id + " data-name='" + data.name+ "' data-price='" + data.price + "' data-description='" + data.description + "' data-content='" + data.content + "' data-img='" + data.img + "'> <i style=\"font-size:17px;\" class=\"fas fa-edit\" ></i></button>" +
            "<button class=\"btn-delete btn btn-danger btn-xs\" style=\"margin-right: 5px\" data-id=" + data.id + " ><i style=\"font-size:17px;\" class=\"fas fa-trash\"></i></button>" +           
          "</td>" +

      "</tr>"
    })
    tbody += '</tbody>'
    $(tbody).insertAfter("#head_table")

    $(".btn-delete").click(function (e) {
      var id = $(this).data("id");
      $("#DeleteStudentModal input[name='id']").val(id);
      $("#DeleteStudentModal").modal("show");
    });

    $(".btn-edit").click(function (e) {
      var id = $(this).data("id");
      var name = $(this).data("name");
      var price = $(this).data("price");
      var description = $(this).data("description");
      var content = $(this).data("content");
    //   console.log(content);
      $("#EditStudentModal input[name='id']").val(id);
      $("#EditStudentModal input[name='name']").val(name);
      $("#EditStudentModal input[name='price']").val(price);
      $("#EditStudentModal textarea[name='description']").val(description);
      $("#EditStudentModal textarea[name='content']").val(content);
      $("#EditStudentModal").modal("show");
    });

    

   }); 
})