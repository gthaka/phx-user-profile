defmodule UserWeb.UsrLiveTest do
  use UserWeb.ConnCase

  import Phoenix.LiveViewTest
  import User.AccountsFixtures

  @create_attrs %{email: "some email", hashed_password: "some hashed_password", confirmed_at: "2023-07-10T05:47:00"}
  @update_attrs %{email: "some updated email", hashed_password: "some updated hashed_password", confirmed_at: "2023-07-11T05:47:00"}
  @invalid_attrs %{email: nil, hashed_password: nil, confirmed_at: nil}

  defp create_usr(_) do
    usr = usr_fixture()
    %{usr: usr}
  end

  describe "Index" do
    setup [:create_usr]

    test "lists all users", %{conn: conn, usr: usr} do
      {:ok, _index_live, html} = live(conn, ~p"/users")

      assert html =~ "Listing Users"
      assert html =~ usr.email
    end

    test "saves new usr", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("a", "New Usr") |> render_click() =~
               "New Usr"

      assert_patch(index_live, ~p"/users/new")

      assert index_live
             |> form("#usr-form", usr: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#usr-form", usr: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users")

      html = render(index_live)
      assert html =~ "Usr created successfully"
      assert html =~ "some email"
    end

    test "updates usr in listing", %{conn: conn, usr: usr} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("#users-#{usr.id} a", "Edit") |> render_click() =~
               "Edit Usr"

      assert_patch(index_live, ~p"/users/#{usr}/edit")

      assert index_live
             |> form("#usr-form", usr: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#usr-form", usr: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/users")

      html = render(index_live)
      assert html =~ "Usr updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes usr in listing", %{conn: conn, usr: usr} do
      {:ok, index_live, _html} = live(conn, ~p"/users")

      assert index_live |> element("#users-#{usr.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#users-#{usr.id}")
    end
  end

  describe "Show" do
    setup [:create_usr]

    test "displays usr", %{conn: conn, usr: usr} do
      {:ok, _show_live, html} = live(conn, ~p"/users/#{usr}")

      assert html =~ "Show Usr"
      assert html =~ usr.email
    end

    test "updates usr within modal", %{conn: conn, usr: usr} do
      {:ok, show_live, _html} = live(conn, ~p"/users/#{usr}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Usr"

      assert_patch(show_live, ~p"/users/#{usr}/show/edit")

      assert show_live
             |> form("#usr-form", usr: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#usr-form", usr: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/users/#{usr}")

      html = render(show_live)
      assert html =~ "Usr updated successfully"
      assert html =~ "some updated email"
    end
  end
end
