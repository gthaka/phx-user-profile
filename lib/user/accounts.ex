defmodule User.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias User.Repo

  alias User.Accounts.Usr

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%Usr{}, ...]

  """
  def list_users do
    Repo.all(Usr)
  end

  @doc """
  Gets a single usr.

  Raises `Ecto.NoResultsError` if the Usr does not exist.

  ## Examples

      iex> get_usr!(123)
      %Usr{}

      iex> get_usr!(456)
      ** (Ecto.NoResultsError)

  """
  def get_usr!(id), do: Repo.get!(Usr, id)

  @doc """
  Creates a usr.

  ## Examples

      iex> create_usr(%{field: value})
      {:ok, %Usr{}}

      iex> create_usr(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_usr(attrs \\ %{}) do
    %Usr{}
    |> Usr.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a usr.

  ## Examples

      iex> update_usr(usr, %{field: new_value})
      {:ok, %Usr{}}

      iex> update_usr(usr, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_usr(%Usr{} = usr, attrs) do
    usr
    |> Usr.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a usr.

  ## Examples

      iex> delete_usr(usr)
      {:ok, %Usr{}}

      iex> delete_usr(usr)
      {:error, %Ecto.Changeset{}}

  """
  def delete_usr(%Usr{} = usr) do
    Repo.delete(usr)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking usr changes.

  ## Examples

      iex> change_usr(usr)
      %Ecto.Changeset{data: %Usr{}}

  """
  def change_usr(%Usr{} = usr, attrs \\ %{}) do
    Usr.changeset(usr, attrs)
  end
end
