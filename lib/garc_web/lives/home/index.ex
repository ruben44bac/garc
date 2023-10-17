defmodule GarcWeb.HomeLive.Index do
  @moduledoc """
  Module for Lives.Home.Index
  """
  use GarcWeb, :live_view

  alias Garc.Contexts.Account.UserManager

  @impl true
  def mount(_params, %{"current_user" => current_user}, socket) do
    send(self(), :after_join)

    {:ok,
     assign(socket,
       page_title: "Home",
       current_user: current_user,
       section_id: 1,
       loading: true,
       users: []
     )}
  end

  @impl true
  def handle_info(:after_join, socket) do
    {:noreply,
     assign(socket,
       loading: false,
       users: UserManager.get_all()
     )}
  end

  @impl true
  def handle_event("dismiss_flash", _params, socket) do
    socket =
      socket
      |> put_flash(:error, nil)
      |> put_flash(:info, nil)

    {:noreply, socket}
  end
end
