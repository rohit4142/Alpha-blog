// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

$(document).ready(() => {
  var id;
  var user_id=parseInt(document.getElementById("user_id").innerText)
  $("#creation").on("adding", function (e, title, cont) {
    
    var datas = { "title": title, "description": cont };
    $.ajax({
      url: `/users/${user_id}/articles`,
      method: "POST",
      contentType: 'application/json',
      data: JSON.stringify(datas),
    
      success: function (data) {
          console.log(data);
          $("#selector").find(
            ".c2"
          ).append(`<eng-article-card name="Article"  id="${data["article_id"]}" titles="${data["title"]}" content="${data["description"]}">
                 <div class="eng-article-datafield">
                <h3>{{titles}}</h3>
                <label class="datafield content-a">{{content}}</label>
                </div>
                </eng-article-card>
                `);
          },
      error: function (error) {
          console.log(`Error ${error}`);
      }
    })
  });

  $(".edit").on("click",(e)=>{
    id= parseInt(e.currentTarget.closest('eng-article-card').id)

    console.log(id)
  })
  

  $(".rohit").on('update',function(e,edited){
    console.log(id)
    console.log(edited)
    
    $.ajax({ 
      url: `/users/${user_id}/articles/${id}`,
      method: "PATCH",
      contentType: 'application/json',
      data: JSON.stringify({ description: edited }),
      success: function (data) {
        console.log(data);
      },
      error: function (error) {
        console.log(error+"h");
      },
    });
  })
  
 
   
  $(".delete").on("click", (e)=> {
   var id= parseInt(e.currentTarget.closest('eng-article-card').id)
    console.log(id)
    $.ajax({
      url: `/users/${user_id}/articles/${id}`,
      method: "DELETE",
      contentType: 'application/json',
      success: function (data) {
        console.log(data);
      },
      error: function (error) {
        console.log(error+"h");
      },
    });
  });

  // document.getElementById("myButton").onclick = function () {
  //   location.href = "http://localhost:4002/login";
  // };
});
