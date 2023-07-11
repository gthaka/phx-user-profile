defmodule User.Repo do
  use Ecto.Repo,
    otp_app: :user,
    adapter: Ecto.Adapters.SQLite3
end
