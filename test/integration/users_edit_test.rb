require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test 'unsucessful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: '',
                                  email: 'foo@invalid',
                                  password: 'bad',
                                  password_confirmation: 'stillbad'
                                  }
    assert_template 'users/edit'
  end

  test 'successful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'new name'
    email = 'new@example.com'
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" 
                                  }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
