defmodule User.AccountsTest do
  use User.DataCase

  alias User.Accounts

  describe "users" do
    alias User.Accounts.Usr

    import User.AccountsFixtures

    @invalid_attrs %{email: nil, hashed_password: nil, confirmed_at: nil}

    test "list_users/0 returns all users" do
      usr = usr_fixture()
      assert Accounts.list_users() == [usr]
    end

    test "get_usr!/1 returns the usr with given id" do
      usr = usr_fixture()
      assert Accounts.get_usr!(usr.id) == usr
    end

    test "create_usr/1 with valid data creates a usr" do
      valid_attrs = %{email: "some email", hashed_password: "some hashed_password", confirmed_at: ~N[2023-07-10 05:47:00]}

      assert {:ok, %Usr{} = usr} = Accounts.create_usr(valid_attrs)
      assert usr.email == "some email"
      assert usr.hashed_password == "some hashed_password"
      assert usr.confirmed_at == ~N[2023-07-10 05:47:00]
    end

    test "create_usr/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_usr(@invalid_attrs)
    end

    test "update_usr/2 with valid data updates the usr" do
      usr = usr_fixture()
      update_attrs = %{email: "some updated email", hashed_password: "some updated hashed_password", confirmed_at: ~N[2023-07-11 05:47:00]}

      assert {:ok, %Usr{} = usr} = Accounts.update_usr(usr, update_attrs)
      assert usr.email == "some updated email"
      assert usr.hashed_password == "some updated hashed_password"
      assert usr.confirmed_at == ~N[2023-07-11 05:47:00]
    end

    test "update_usr/2 with invalid data returns error changeset" do
      usr = usr_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_usr(usr, @invalid_attrs)
      assert usr == Accounts.get_usr!(usr.id)
    end

    test "delete_usr/1 deletes the usr" do
      usr = usr_fixture()
      assert {:ok, %Usr{}} = Accounts.delete_usr(usr)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_usr!(usr.id) end
    end

    test "change_usr/1 returns a usr changeset" do
      usr = usr_fixture()
      assert %Ecto.Changeset{} = Accounts.change_usr(usr)
    end
  end
end
