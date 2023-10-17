defmodule GarcWeb.PaginatorComponent do
  @moduledoc """
  GarcWeb.PaginatorComponent
  """
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div class="w-full mb-10">
      <div class="hidden lg:inline-flex w-full items-center pt-6">
        <div>
          <p class="text-sm text-gray-700">
            Viendo
            <span class="font-medium">
              <%= @page_size * (@page_number - 1) %>
            </span>
            a
            <span class="font-medium">
              <%= if (@page_number * @page_size) > @total_entries, do: @total_entries, else: (@page_number * @page_size) %>
            </span>
            de
            <span class="font-medium">
              <%= @total_entries %>
            </span>
            resultados
          </p>
        </div>
        <div class="ml-auto">
          <nav class="isolate inline-flex -space-x-px rounded-md shadow-sm" aria-label="Pagination">
            <button phx-click="change_page" phx-value-page={@page_number - 1}
              class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">
              <span class="sr-only">Previous</span>
              <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd"
                  d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z"
                  clip-rule="evenodd" />
              </svg>
            </button>
            <%= if @total_pages> 6 do %>
              <%= for page <- 1..@total_pages do %>
                <%= if page>= @page_number do %>
                  <%= if page< (@page_number + 3) || page> (@total_pages - 3) do %>
                    <button phx-click="change_page" phx-value-page={page} aria-current="page" class={if page==@page_number ,
                      do: "relative inline-flex items-center bg-cyan-600 px-4 py-2 text-sm font-semibold text-white" ,
                      else: "relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
                      }>
                      <%= page %>
                    </button>
                  <% end %>
                  <%= if @page_number + 4 == page do %>
                    <span
                      class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-700 ring-1 ring-inset ring-gray-300 focus:outline-offset-0">...</span>

                  <% end%>
                <% end %>
              <% end %>
            <% else %>
            <%= for page <- 1..@total_pages do %>
              <button phx-click="change_page" phx-value-page={page} class={if page==@page_number ,
                do: "relative inline-flex items-center bg-cyan-600 px-4 py-2 text-sm font-semibold text-white",
                else: "relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
                } aria-current="page">
                <%= page %>
              </button>
            <% end %>
            <% end %>

            <button phx-click="change_page" phx-value-page={@page_number + 1}
              class="relative inline-flex items-center rounded-r-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0">
              <span class="sr-only">Next</span>
              <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd"
                  d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                  clip-rule="evenodd" />
              </svg>
            </button>
          </nav>
        </div>
      </div>
      <%= if @page_number<@total_pages do %>
      <div class="w-full flex py-2 lg:hidden">
        <button phx-click="more_page" class="px-4 py-2 rounded-lg bg-cyan-800 text-white mx-auto text-sm font-bold">
          Ver más
        </button>
      </div>
      <% end %>
    </div>
    """
  end

  def mount(socket) do
    {:ok,
     assign(socket,
       page_number: 1,
       page_size: 1,
       total_entries: 1,
       total_pages: 1
     )}
  end

  def update(attrs, socket) do
    {:ok,
     assign(socket,
       page_number: attrs.page_number,
       page_size: attrs.page_size,
       total_entries: attrs.total_entries,
       total_pages: attrs.total_pages
     )}
  end
end
