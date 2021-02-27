defmodule Rocketpay.NumbersTest do
  use ExUnit.Case, async: true

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "should return the sum of the comma-separated numbers, when the file is valid" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, %{result: 33}}

      assert response == expected_response
    end

    test "should return an error, when the file is invalid" do
      response = Numbers.sum_from_file("invalid")

      expected_response = {:error, %{message: "Invalid file!"}}

      assert response == expected_response
    end
  end
end
