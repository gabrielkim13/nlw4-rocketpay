defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Ecto.Changeset

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "should return a user when all params are valid" do
      params = %{
        name: "test",
        age: 24,
        email: "test@test.com",
        password: "123456",
        nickname: "test"
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "test", age: 24, email: "test@test.com", nickname: "test", id: ^user_id} = user
    end

    test "should return an error and a changeset when some of the params are valid" do
      params = %{
        name: "test",
        age: 14,
        email: "test@test.com",
        password: "1234",
        nickname: "test"
      }

      {:error, %Changeset{} = changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"],
      }

      assert expected_response == errors_on(changeset)
    end
  end
end
