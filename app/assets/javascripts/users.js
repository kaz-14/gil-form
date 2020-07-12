$(function() {
  function addUser(user) {
    let html = `
                <div class="ChatMember">
                  <p class="ChatMember__name">${user.nickname}</p>
                  <div class="ChatMember__add ChatMember__button" data-user-id="${user.id}" data-user-name="${user.nickname}">追加</div>
                </div>
                `;
    $("#UserSearchResult").append(html);
  }

  function addNoUser() {
    let html = `
                <div class="ChatMember">
                  <p class="ChatMember__name">ユーザーが見つかりません</p>
                </div>
                `;
    $("#UserSearchResult").append(html);
  }

  function addMember(nickname, id) {
    let html = `
                <div class="ChatMember">
                  <p class="ChatMember__name">${nickname}</p>
                  <input name="group[user_ids][]" type="hidden" value="${id}" />
                  <div class="ChatMember__remove ChatMember__button">削除</div>
                </div>
                `;
    $(".ChatMembers").append(html);
  }

  $("#UserSearch__field").on("keyup", function() {
    let input = $("#UserSearch__field").val();
    $.ajax({
      type: "GET",
      url: "/users",
      data: { keyword: input },
      dataType: "json"
    })
    .done(function(users) {
      $("#UserSearchResult").empty();
      if (users.length !== 0) {
        users.forEach(function(user) {
          addUser(user);
        });
      } else if (input.length == 0) {
        return false;
      } else {
        addNoUser();
      }
    })
    .fail(function() {
      alert("通信エラーです。ユーザーが表示できません。");
    });
  });
  $("#UserSearchResult").on("click", ".ChatMember__add", function() {
    const userNickname = $(this).attr("data-user-name");
    const userId = $(this).attr("data-user-id");
    $(this).parent().remove();
    addMember(userNickname, userId);
  });
  $(".ChatMembers").on("click", ".ChatMember__remove", function() {
    $(this).parent().remove();
  });
});