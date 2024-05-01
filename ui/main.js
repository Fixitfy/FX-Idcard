$(document).ready(function () {
    $(".id-card").hide();
    $(".photograph").hide();
    $(".printphoto").hide();
    $(".create").hide();
    $(".previewcreate-photo").hide();

    function setupIDCard(array) {
        var sex = "M"
        if (array.sex == "Female"){
            sex = "F";
        }
        $(".charid").html(array.charid)
        $(".license").html(`RODEO-${array.charid}`)
        $(".sex").html(sex)
        $(".hair").html(array.hair)
        $(".eyes").html(array.eye)
        $(".height").html(array.height)
        $(".weight").html(array.weight)
        $(".religious").html(array.religious)
        $(".dateofbirth").html(array.date)
        $(".age").html(array.age)
        $(".name").html(array.name)
        $(".country").html(array.country)
        $(".card-zone").html(array.cityname)
        $(".playerimg").attr("src", array.img)
        $(".id-card").slideDown(1000)
    }

    function closeIDCard() {
        $(".id-card").slideUp(1000);
    }
    $("#submit").click(function () {
        var name = $("#name").val();
        var cityname = $("#cityname").val();
        var religious = $("#religious").val();
        var age = $("#ageinput").val();
        var dateinput = $("#dateinput").val();
        var heightinput = $("#heightinput").val();
        var weightinput = $("#weightinput").val();
        var hair = $("#hair").val();
        var eye = $("#eye").val();
        var sex = "Male";
        if ($("#sex-women").prop('checked')==true){
            sex = "Female";
        }
        var img = $('#previewphoto').attr('src');
        $.post(`https://${GetParentResourceName()}/createIdCard`, JSON.stringify({
            name: name,
            cityname: cityname,
            religious: religious,
            age: age,
            date: dateinput,
            height: heightinput,
            weight: weightinput,
            hair: hair,
            eye: eye,
            sex: sex,
            img: img
        }));
        closePrintPhoto();
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
    });
    function CreateIdCardSetData(data) {
        $("#name").val(data.name);
        $("#cityname").val(data.city);
        $("#religious").val(data.religious);
        $("#ageinput").val(data.age);
        $("#weightinput").val(`${data.weight}KG`);
        if (data.gender === "Male") {
            $("#sex-man").prop("checked", true);
            $("#sex-women").prop("checked", false);
        } else if (data.gender === "Female") {
            $("#sex-women").prop("checked", true);
            $("#sex-man").prop("checked", false);
        }
        $("#sex-man, #sex-women").change(function () {
            var checkedCheckbox = $(this);
            $("#sex-man, #sex-women").not(checkedCheckbox).prop("checked", false);
        });
        var maxYear = 1899 - data.age;
        var maxDate = maxYear + "-12-31";
        var minDate = maxYear + "-01-01";
        $("#dateinput").attr("max", maxDate);
        $("#dateinput").attr("min", minDate);
        $("#previewphoto").attr("src", data.img);
        var randomDay = Math.floor(Math.random() * 28) + 1;
        var randomMonth = Math.floor(Math.random() * 12) + 1;
        // var randomDate = maxYear + "-" + (randomMonth < 10 ? "0" + randomMonth : randomMonth) + "-" + (randomDay < 10 ? "0" + randomDay : randomDay);
        $("#dateinput").val(maxYear+"-01-01");
        var heightText = "";
        switch (data.height) {
            case 0.85:
                heightText = "4'8";
                break;
            case 0.90:
                heightText = "4'9";
                break;
            case 0.95:
                heightText = "4'10";
                break;
            case 1.0:
                heightText = "5'0";
                break;
            case 1.05:
                heightText = "5'1";
                break;
            case 1.10:
                heightText = "5'2";
                break;
            default:
                heightText = "5'0";
                break;
        }
        $("#heightinput").val(heightText);
    }
    function closePrintPhoto() {
        $(".photograph").fadeOut(500);
        $(".printphoto").fadeOut(500);
        $(".create").fadeOut(500);
        $(".previewcreate-photo").fadeOut(500);
    }
    $(".preview").click(function () {
        var imgLink = $("#link").val();
        if (imgLink) {
            $(".photo").attr("src", imgLink);
        } else {
            $.post(`https://${GetParentResourceName()}/notify`, JSON.stringify({
                text: "noimg"
            }));
        }
    });
    $(".close, .close-create").click(function () {
        closePrintPhoto();
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
    });
    $(".print").click(function () {
        var imgLink = $("#link").val();
        if (imgLink) {
            closePrintPhoto();
            $.post(`https://${GetParentResourceName()}/print`, JSON.stringify({
                imgLink: imgLink
            }));
        } else {
            $.post(`https://${GetParentResourceName()}/notify`, JSON.stringify({
                text: "noimg"
            }));
        }
    });

    $(document).keyup(function (e) {
        if (e.key === "Escape") {
            closePrintPhoto();
            closeIDCard();
            $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
        }
    });

    window.addEventListener('message', function (event) {
        switch (event.data.action) {
            case 'openIdCard':
                setupIDCard(event.data.array);
                break;
            case 'close':
                closeIDCard();
                break;
            case 'print':
                $(".printphoto").fadeIn(500);
                break;
            case 'showphoto':
                var img = event.data.array.img
                console.log(img)
                $(".photograph .photo").attr("src", img);
                $(".photograph").fadeIn(500);
                break;
            case 'createidcard':
                var data = event.data.array
                CreateIdCardSetData(data)
                $(".create").fadeIn(500);
                $(".previewcreate-photo").fadeIn(500);
                break;
        }
    });
});
