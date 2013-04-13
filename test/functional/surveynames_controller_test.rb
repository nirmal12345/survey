require 'test_helper'

class SurveynamesControllerTest < ActionController::TestCase
  fixtures :users
  
  setup do
    @admin = users(:admin)
  end

  test "should get surveynames" do
    survey1 = surveynames(:survey1)
    get :index, {}, {:description=> survey1.description, :user_id => users(:admin).id }
    assert_response :success
  end

  test "rendering page to create new survey" do
    get :new, {}, { :user_id => users(:admin).id }
    assert_response :success
    assert_template "new"
  end
  
  test "create a new survey" do    
    admin_user(@admin) do
      survey1 = surveynames(:survey1)
      post :create, :description=> survey1.description, :user_id => users(:admin).id
      assert_response :success
      assert_redirected_to surveynames_path
    end
  end
  
  test "rendering page to edit survey" do
    admin_user(@admin) do
      get :edit, id: surveynames(:survey1)
      assert_response :success
    end
  end
  
  test "update survey" do
    admin_user(@admin) do
      put :update, id: surveynames(:survey1), surveyname: { description: surveynames(:survey1).name, :user_id => users(:admin).id }
      assert_redirected_to surveynames_path
    end
  end
  
  test "delete survey" do
    admin_user(@admin) do
      delete :destroy, id: surveynames(:survey1)
      assert_redirected_to surveynames_path
    end
  end
  
end
