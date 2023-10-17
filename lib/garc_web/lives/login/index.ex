defmodule GarcWeb.LoginLive.Index do
  use GarcWeb, :live_view

  alias GarcWeb.Guardian.Guardian
  alias Garc.Contexts.Account.UserManager
  alias GarcWeb.Util.Session

  def mount(_params, session, socket) do
    socket = Session.put_session_token_assigns(session, socket)
    socket = Session.put_session_remember_assigns(session, socket)

    {:ok,
     assign(socket,
       page_title: "Login",
       loading: false,
       form: init_form(session)
     )}
  end

  def handle_event("update_form", %{"login" => params}, socket) do
    {:noreply, assign(socket, form: params)}
  end

  def handle_event(
        "login",
        %{"login" => %{"email" => email, "password" => password} = params},
        socket
      ) do
    UserManager.authenticate_user(email, password)
    |> case do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user, %{}, ttl: {5_184_000, :second})

        if params["remember"] == "on",
          do: PhoenixLiveSession.put_session(socket, "remember_credentials", params),
          else: PhoenixLiveSession.put_session(socket, "remember_credentials", nil)

        PhoenixLiveSession.put_session(socket, "guardian_default_token", token)
        {:noreply, socket |> redirect(to: "/home")}

      {:error, :invalid_credentials} ->
        {:noreply, put_flash(socket, :error, "Usuario o contraseña incorrectos")}
    end
  end

  def handle_event("dismiss_flash", _params, socket) do
    socket = put_flash(socket, :error, nil)
    {:noreply, socket}
  end

  def handle_info({:live_session_updated, session}, socket) do
    {:noreply, Session.put_session_token_assigns(session, socket)}
  end

  def init_form(%{"remember_credentials" => nil}),
    do: init_form(nil)

  def init_form(%{"remember_credentials" => remember_credentials}),
    do: remember_credentials

  def init_form(_session) do
    Map.new()
    |> Map.put("email", "")
    |> Map.put("password", "")
    |> Map.put("remember", "")
  end
end
