defmodule User.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :hashed_password, :string
      add :confirmed_at, :naive_datetime

      timestamps()
    end
  end
end
