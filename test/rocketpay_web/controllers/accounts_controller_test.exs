defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{User, Account}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "test",
        age: 24,
        email: "test@test.com",
        password: "123456",
        nickname: "test"
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic dGVzdDoxMjM0NTY=") # test:123456

      {:ok, conn: conn, account_id: account_id}
    end

    test "should execute a deposit when all params are valid", %{conn: conn, account_id: account_id} do
      params = %{value: 50}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:created)

      assert %{
        "account" => %{"balance" => "50", "id" => _id},
        "message" => "Balance updated"
      } = response
    end

    test "should return an error when the value is invalid", %{conn: conn, account_id: account_id} do
      params = %{value: "invalid"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:bad_request)

      assert %{"message" => "Invalid transaction"} == response
    end
  end
end
