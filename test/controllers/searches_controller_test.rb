require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "#create - Should return 204 if params 'search' are not the one defined" do
    post searches_path, params: {
      search: { whatever: "test" }
    }

    assert_response 204
  end

  test "#create - Should return 400 if params 'search' are empty" do
    post searches_path, params: {
      search: {}
    }

    assert_response 400
  end

  test "#create - Should return 400 if no params" do
    post searches_path

    assert_response 400
  end

  test "#create - Should call `by_city` method from weather service if city param" do
    mock = Minitest::Mock.new
    mock.expect :by_city, true, city: "Lille"

    WeatherService.stub :new, mock do
      post searches_path, params: {
        search: {
          city: "Lille"
        }
      }
    end

    assert_mock mock
  end

  test "#create - Should call `by_coordinates` method from weather service if lat & long param" do
    mock = Minitest::Mock.new
    mock.expect :by_coordinates, true, lat: "0", lon: "0"

    WeatherService.stub :new, mock do
      post searches_path, params: {
        search: {
          lat: 0,
          lon: 0
        }
      }
    end

    assert_mock mock
  end
end
