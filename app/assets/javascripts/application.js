// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-ui/draggable
//= require jquery-ui/droppable
//= require jquery-ui/resizable
//= require jquery-ui/selectable
//= require jquery-ui/sortable
//= require_tree .

function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $("#myList").append(content.replace(regexp, new_id));
    $("#myList tr:last select").val($("#myList tr").length-1);
}

$(function() {
    $('#pictureInput').on('change', function(event) {
        var files = event.target.files;
        var image = files[0];
        var reader = new FileReader();
        reader.onload = function(file) {
            $('#target').attr("src", file.target.result);
        };
        reader.readAsDataURL(image);
    });

    $('#pictureInput2').on('change', function(event) {
        var files = event.target.files;
        var image = files[0];
        var reader = new FileReader();
        reader.onload = function(file) {
            $('#target2').attr("src", file.target.result);
        };
        reader.readAsDataURL(image);
    });

    $("#myList").sortable({
        items: 'tr',
        update: function() {
            $.ajax({
                type: 'post',
                data: $('#myList').sortable('serialize'),
                dataType: 'script',
                url: '/recipe_steps/sort'
            });
        }
        });

    $('#remove_recipe').click(function() {
        // Some complex code
        remove_fields(this);
    });

    $('.dynamic_add').click(function() {
        add_fields(this, this.attributes['data-association'].value, this.attributes['data-content'].value);
    });

    $('#recipe_ingredient_tokens').tokenInput("/ingredients.json", {
        preventDuplicates: true,
        crossDomain:false,
        propertyToSearch:"name",
        prePopulate: $('#recipe_ingredient_tokens').data("pre"),
        theme: "facebook"
    });


    $('#recipe_category_tokens').tokenInput("/categories.json", {
        preventDuplicates: true,
        crossDomain:false,
        prePopulate: $('#recipe_category_tokens').data("pre"),
        theme: "facebook"
    });

    $('#list_recipe_tokens').tokenInput("/recipes.json", {
        preventDuplicates: true,
        crossDomain:false,
        prePopulate: $('#list_recipe_tokens').data("pre"),
        theme: "facebook"
    });

    $('#recipe_garnish_tokens').tokenInput("/garnishes.json", {
        preventDuplicates: true,
        crossDomain:false,
        prePopulate: $('#recipe_garnish_tokens').data("pre"),
        theme: "facebook"
    });

    $('#recipe_similar_recipe_tokens').tokenInput("/recipes.json", {
        preventDuplicates: true,
        crossDomain:false,
        prePopulate: $('#recipe_similar_recipe_tokens').data("pre"),
        theme: "facebook"
    });


});