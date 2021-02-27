defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{User, Account}
  alias RocketpayWeb.UsersView

  test "should be able to render create.json" do
    params = %{
      name: "test",
      age: 24,
      email: "test@test.com",
      password: "123456",
      nickname: "test"
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      user: %{
        id: user_id,
        name: "test",
        nickname: "test",
        account: %{id: account_id, balance: Decimal.new("0")}
      },
      message: "User created"
    }

    assert expected_response == response
  end
end
