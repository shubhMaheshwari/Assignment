function hide_all_containers() {
  // TODO: consider refactoring to addClass in a loop
  console.log("hide containers");
  $('#get-all-users-container').addClass("hidden");
  $('#add-user-container').addClass("hidden");
  $('#edit-user-container').addClass("hidden");
  $('#delete-user-container').addClass("hidden");
  $('#add-user-btn').addClass("hidden");
};

var setAddHash = function() {
  window.location.hash='add_user';
};

var setEditHash = function() {
  window.location.hash='edit_user';
};

var setDelHash = function() {
  window.location.hash='delete_user';
};

var setIndexHash = function() {
  window.location.hash='index';
};

function navigate(path) {
  var current = window.location.href;
  window.location.href = current.replace(/#(.*)$/, '') + '#' + path;
};

//strip # from window.location.hash
function get_window_hash_path() {
  return location.hash.substring(1);
};

function register_onhashchange_handlers(handler_functions) {
  $(window).on("hashchange", function(e) {
    //strip hash out
    hash_path = get_window_hash_path();
    console.log("new hash: ", hash_path);
    //we use hasOwnProperty since we need to check if a handler is 
    // defined for the hash_path
    //object has it, not its parents (in the prototype chain)
    if (handler_functions.hasOwnProperty(hash_path)) {
      //invoke said handler function
      handler_functions[hash_path]();
    } else {
      console.warn(`no handler for ${hash_path}`);
    }
  });
};


window.onload = function() {
  register_onhashchange_handlers({
    index: get_all_users_handler,
    get_all_users: get_all_users_handler,
    add_user: add_user_handler,
    edit_user: edit_user_handler,
    delete_user: delete_user_handler});

  let current_hash = get_window_hash_path();
  if (current_hash === "") {
    console.log("defaulting #url to get_all_users");
    current_hash = "index";
    console.log("navigating to: #" + current_hash);
    navigate(current_hash);
  }
  
  $(window).trigger("hashchange");
  
};

function get_all_users_handler() {
  console.log("get_all_users_handler");
  hide_all_containers();
  $('#get-all-users-container').removeClass("hidden");
  $('#add-user-btn').removeClass("hidden");

  $('#add-user-btn #add')[0].addEventListener("click", setAddHash);
                   
  let editBtns = $('#get-all-users-container #edit');
  let delBtns =  $('#get-all-users-container #delete');


  for (editBtn of editBtns) {
    editBtn.removeEventListener('click', setEditHash);
    editBtn.addEventListener('click', setEditHash);
  };

  for (delBtn of delBtns) {
    delBtn.removeEventListener('click', setDelHash);
    delBtn.addEventListener('click', setDelHash);
  };

};

function add_user_handler() {
  console.log("add user handler")
  hide_all_containers();
  $('#add-user-container').removeClass("hidden");
  $('#add-user-container #add')[0].addEventListener("click", setIndexHash);
  $('#add-user-container #cancel')[0].addEventListener("click", setIndexHash);
}

function edit_user_handler() {
  console.log("edit user handler")
  hide_all_containers();
  $('#edit-user-container').removeClass("hidden");
  $('#edit-user-container #done')[0].addEventListener("click", setIndexHash);
  $('#edit-user-container #cancel')[0].addEventListener("click", setIndexHash);
}

function delete_user_handler() {
  console.log("delete user handler")
  hide_all_containers();
  $('#delete-user-container').removeClass("hidden");
  $('#delete-user-container #delete')[0].addEventListener("click", setIndexHash);
  $('#delete-user-container #cancel')[0].addEventListener("click", setIndexHash);
}
