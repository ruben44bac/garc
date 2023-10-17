defmodule GarcWeb.ProductLive.Index do
  @moduledoc """
  Module for Lives.RolLive.Index
  """
  use GarcWeb, :live_view

  alias Garc.Contexts.Product.ProductManager

  @pagination %{page: 1, page_size: 10}

  @impl true
  def mount(_params, %{"current_user" => current_user}, socket) do
    send(self(), :after_join)

    {:ok,
     assign(socket,
       current_user: current_user,
       page_title: "Productos",
       section_id: 2,
       loading: true,
       form: %{},
       pagination: @pagination,
       search_modal: %{show: false, text: nil}
     )}
  end

  @impl true
  def handle_info(:after_join, socket) do
    data = get_all(socket.assigns.pagination)
    {:noreply, assign(socket, data: data, loading: false)}
  end

  @impl true
  def handle_event("dismiss_flash", _params, socket) do
    socket =
      socket
      |> put_flash(:error, nil)
      |> put_flash(:info, nil)

    {:noreply, socket}
  end

  def handle_event("start_search", _params, socket) do
    search_modal = %{socket.assigns.search_modal | show: !socket.assigns.search_modal.show}
    {:noreply, assign(socket, search_modal: search_modal)}
  end

  def handle_event("change_form", params, socket) do
    {:noreply, assign(socket, form: params)}
  end

  def handle_event("submit_form", params, socket) do
    data = get_all(@pagination, params)
    search_modal = %{socket.assigns.search_modal | show: false, text: params["name"]}
    {:noreply, assign(socket, form: params, data: data, search_modal: search_modal)}
  end

  def handle_event("change_page", %{"page" => page_string}, socket) do
    pagination =
      socket.assigns.pagination
      |> Map.put(:page, String.to_integer(page_string))

    data = get_all(pagination, socket.assigns.form)

    {:noreply, assign(socket, pagination: pagination, data: data)}
  end

  def handle_event("more_page", _params, socket) do
    pagination =
      socket.assigns.pagination
      |> Map.put(:page, socket.assigns.pagination.page + 1)

    data =
      pagination
      |> get_all(socket.assigns.form)
      |> then(&Map.put(&1, :entries, socket.assigns.data.entries ++ &1.entries))

    {:noreply, assign(socket, pagination: pagination, data: data)}
  end

  defp get_all(pagination, filters \\ %{}) do
    ProductManager.get_all([], [], [], pagination)
  end
end
