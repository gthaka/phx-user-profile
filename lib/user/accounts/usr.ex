defmodule User.Accounts.Usr do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :hashed_password, :string
    field :confirmed_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(usr, attrs) do
    usr
    |> cast(attrs, [:email, :hashed_password, :confirmed_at])
    |> validate_required([:email, :hashed_password, :confirmed_at])
  end
end
