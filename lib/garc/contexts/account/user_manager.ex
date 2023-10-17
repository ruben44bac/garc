defmodule Garc.Contexts.Account.UserManager do
  import Ecto.Query, warn: false

  use Garc.Contexts.BaseManager,
    schema: Garc.Contexts.Account.User,
    repo: Garc.Repo,
    only: [:get, :get!, :get_all, :create, :update]

  # alias GarcWeb.Guardian.Guardian

  alias Garc.Contexts.Account.User

  alias Garc.Repo

  def authenticate_user(email, plain_text_password) do
    query = from(u in User, where: u.email == ^email)

    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plain_text_password, user.password_hash) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
