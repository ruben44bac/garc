defmodule GarcWeb.Util.Session do
  @moduledoc """
  Module for Utils.Session
  """
  use GarcWeb, :live_view

  def render(assigns) do
    ~H"""
    ...
    """
  end

  def put_session_token_assigns(session, socket) do
    socket
    |> PhoenixLiveSession.maybe_subscribe(session)
    |> assign(:guardian_default_token, Map.get(session, "guardian_default_token", []))
  end

  def put_session_remember_assigns(session, socket) do
    socket
    |> PhoenixLiveSession.maybe_subscribe(session)
    |> assign(:remember_credentials, Map.get(session, "remember_credentials", []))
  end
end
