defmodule GarcWeb.Guardian.Guardian do
  @moduledoc """
  Module for Guardian
  """
  use Guardian, otp_app: :garc

  alias Garc.Contexts.Account.UserManager

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    IO.inspect(id, label: "ID ---> ")

    user =
      UserManager.get(id, [:account, :rol])
      |> IO.inspect(label: "user -> ")

    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
