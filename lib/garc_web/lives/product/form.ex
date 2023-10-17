defmodule GarcWeb.ProductLive.Form do
  @moduledoc """
  Module for GarcWeb.ProductLive.Form
  """
  alias Garc.Contexts.Product.ProductTaxManager
  alias Garc.Contexts.Product.ProductTax
  use GarcWeb, :live_view

  alias Garc.Contexts.Product.ProductCategoryManager
  alias Garc.Contexts.Product.ProductManager
  alias Garc.Contexts.Product.CategoryManager
  alias Garc.Contexts.Product.UnitManager

  alias GarcWeb.Utils.Maps

  @impl true
  def mount(_params, %{"current_user" => current_user}, socket) do
    send(self(), :after_join)

    {:ok,
     assign(socket,
       current_user: IO.inspect(current_user, label: "current -> "),
       section_id: 2,
       loading: true,
       actual_steper: 1,
       categories: [],
       units: [],
       unit_packings: [],
       product_taxes: [],
       stepers: get_stepers(),
       form_1: %{},
       form_2: %{},
       form_3: %{}
     )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info(:after_join, socket) do
    categories =
      CategoryManager.get_all(account_id: socket.assigns.current_user.account_id, is_active: true)

    units = UnitManager.get_all(type: 1)
    unit_packings = UnitManager.get_all(type: 2)

    {:noreply,
     assign(socket,
       categories: categories,
       units: units,
       unit_packings: unit_packings,
       loading: false
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

  def handle_event("form_change_1", params, socket) do
    {:noreply, assign(socket, form_1: params)}
  end

  def handle_event("form_change_2", params, socket) do
    {:noreply, assign(socket, form_2: params)}
  end

  def handle_event("form_change_3", params, socket) do
    {:noreply, assign(socket, form_3: params)}
  end

  def handle_event("form_submit_1", _params, %{assigns: %{live_action: :new}} = socket) do
    socket.assigns.form_1
    |> Map.put("account_id", socket.assigns.current_user.account_id)
    |> Map.put(
      "is_inventory",
      socket.assigns.form_1["is_inventory"] == "true" ||
        socket.assigns.form_1["is_inventory"] == true
    )
    |> Map.put(
      "is_sale",
      socket.assigns.form_1["is_sale"] == "true" || socket.assigns.form_1["is_sale"] == true
    )
    |> Map.put(
      "is_buy",
      socket.assigns.form_1["is_buy"] == "true" || socket.assigns.form_1["is_buy"] == true
    )
    |> ProductManager.create()
    |> case do
      {:ok, product} ->
        save_categories(socket.assigns.form_1, product)

        {:noreply,
         socket
         |> put_flash(:info, "Datos guardados")
         |> redirect(to: "/products/edit/#{product.id}/2")}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, inspect(error))}
    end
  end

  def handle_event("form_submit_1", _params, %{assigns: %{live_action: :edit}} = socket) do
    form =
      socket.assigns.form_1
      |> Map.put("is_inventory", socket.assigns.form_1["is_inventory"] == "true")
      |> Map.put("is_sale", socket.assigns.form_1["is_sale"] == "true")
      |> Map.put("is_buy", socket.assigns.form_1["is_buy"] == "true")

    socket.assigns.entity
    |> ProductManager.update(form)
    |> case do
      {:ok, product} ->
        {:noreply,
         assign(socket,
           actual_steper: 2,
           entity: ProductManager.preloads(product, [:product_taxes])
         )}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, inspect(error))}
    end
  end

  def handle_event("form_submit_2", _params, socket) do
    form =
      socket.assigns.form_2
      |> Map.put(
        "is_negative_allow",
        socket.assigns.form_2["is_negative_allow"] == "true" ||
          socket.assigns.form_2["is_negative_allow"] == true
      )
      |> Map.put(
        "is_price_updated",
        socket.assigns.form_2["is_price_updated"] == "true" ||
          socket.assigns.form_2["is_price_updated"] == true
      )

    socket.assigns.entity
    |> ProductManager.update(form)
    |> case do
      {:ok, product} ->
        {:noreply, assign(socket, actual_steper: 3)}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, inspect(error))}
    end
  end

  def handle_event("form_submit_3", _params, socket) do
    ProductTaxManager.clean_product(socket.assigns.entity.id)

    socket.assigns.form_3
    |> Map.delete("_target")
    |> Map.to_list()
    |> Enum.map(fn {k, v} ->
      aux = k |> String.split("_")

      Map.new()
      |> Map.put(List.first(aux), v)
      |> Map.put("id", List.last(aux))
    end)
    |> Enum.group_by(fn data -> data["id"] end)
    |> Enum.map(fn {_k, v} ->
      v
      |> List.first()
      |> Map.merge(List.last(v))
      |> Map.delete("id")
      |> Map.put("product_id", socket.assigns.entity.id)
      |> ProductTaxManager.create()
    end)
    |> IO.inspect(label: "list _> ")

    {:noreply,
     socket
     |> put_flash(:info, "Datos guardados")
     |> redirect(to: "/products")}
  end

  def handle_event("new_tax", _params, socket) do
    new_id =
      socket.assigns.product_taxes
      |> List.last()
      |> case do
        nil -> 1
        val -> val.id + 1
      end

    product_taxes =
      socket.assigns.product_taxes
      |> Kernel.++([%{id: new_id}])

    {:noreply, assign(socket, product_taxes: product_taxes)}
  end

  def handle_event("delete_tax", %{"id" => string_id}, socket) do
    id = String.to_integer(string_id)

    socket.assigns.product_taxes
    |> Enum.find(&(&1.id == id))
    |> case do
      %ProductTax{} = value -> ProductTaxManager.delete(value)
      _any -> nil
    end

    product_taxes = Enum.filter(socket.assigns.product_taxes, &(&1.id != id))

    {:noreply, assign(socket, product_taxes: product_taxes)}
  end

  defp apply_action(socket, :edit, %{"id" => id} = params) do
    entity =
      ProductManager.get!(id, [:product_taxes])
      |> IO.inspect(label: "whats -> ")

    actual_steper = if is_nil(params["step"]), do: 1, else: String.to_integer(params["step"])
    form = build_form(entity)

    socket
    |> assign(:page_title, "Edición de producto")
    |> assign(:entity, entity)
    |> assign(:product_taxes, entity.product_taxes)
    |> assign(:actual_steper, actual_steper)
    |> assign(:form_1, form)
    |> assign(:form_2, form)
    |> assign(:form_3, build_form_3(entity.product_taxes))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Nuevo producto")
    |> assign(:entity, %{})
    |> assign(:form_1, build_form())
  end

  defp save_categories(
         %{"category_id_1" => category_id_1, "category_id_2" => category_id_2},
         %{id: id}
       ) do
    ProductCategoryManager.clean_product(id)

    if !is_nil(category_id_1) && category_id_1 != "" do
      ProductCategoryManager.create(%{
        type: 1,
        category_id: category_id_1,
        product_id: id
      })

      if !is_nil(category_id_2) && category_id_2 != "" do
        ProductCategoryManager.create(%{
          type: 2,
          category_id: category_id_2,
          product_id: id
        })
      end
    end
  end

  defp get_stepers() do
    [
      %{
        id: 1,
        name: "General",
        description: ""
      },
      %{
        id: 2,
        name: "Medidas",
        description: ""
      },
      %{
        id: 3,
        name: "Impuestos",
        description: ""
      }
    ]
  end

  defp build_form(struct) do
    struct
    |> Map.delete(:__meta__)
    |> Map.delete(:__struct__)
    |> Maps.key_to_string()
  end

  defp build_form do
    %{}
  end

  defp build_form_3(product_taxes) do
    Enum.reduce(product_taxes, %{}, fn pt, acc ->
      acc
      |> Map.put("amount_#{pt.id}", "#{pt.amount}")
      |> Map.put("type_#{pt.id}", "#{pt.type}")
    end)
  end
end
