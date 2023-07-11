defmodule User.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `User.Accounts` context.
  """

  @doc """
  Generate a usr.
  """
  def usr_fixture(attrs \\ %{}) do
    {:ok, usr} =
      attrs
      |> Enum.into(%{
        email: "some email",
        hashed_password: "some hashed_password",
        confirmed_at: ~N[2023-07-10 05:47:00]
      })
      |> User.Accounts.create_usr()

    usr
  end
end
