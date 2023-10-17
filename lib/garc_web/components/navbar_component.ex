defmodule GarcWeb.NavBarComponent do
  @moduledoc """
  Module for SideBarComponent
  """
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_component
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div>
      <div class="hidden lg:flex w-64 lg:flex-col lg:inset-y-0 h-screen">
        <!-- Sidebar component, swap this element with another sidebar if you like -->
        <div class="flex flex-col flex-grow bg-cyan-700 rounded-r-xl pt-5 pb-4 overflow-y-auto h-full fixed top-0 left-0 lg:w-64">
          <div class="flex items-center flex-shrink-0 px-4 text-3xl text-cyan-100 font-bold text-center">
          Garc
          </div>
          <nav class="mt-5 flex-1 flex flex-col divide-y divide-cyan-800 overflow-y-auto" aria-label="Sidebar">
            <div class="px-2 space-y-1">
              <%= for s <- @sections do %>
                <a href={s.url} class={s.class} aria-current="page">
                  <%= Phoenix.HTML.raw(s.svg) %>
                  <%= s.name %>
                </a>
              <% end %>
            </div>
            <div class="mt-6 pt-6">
              <div class="px-2 space-y-1">
                <a href="/profile" class="group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md text-cyan-100 hover:text-white hover:bg-cyan-500">
                  <!-- Heroicon name: outline/cog -->
                  <svg class="mr-4 h-6 w-6 text-cyan-100" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                  </svg>
                  Perfil
                </a>
                <a href="#" class="group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md text-cyan-100 hover:text-white hover:bg-cyan-500">
                  <!-- Heroicon name: outline/question-mark-circle -->
                  <svg class="mr-4 h-6 w-6 text-cyan-100" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  Ayuda
                </a>
                <a href="#" class="group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md text-cyan-100 hover:text-white hover:bg-cyan-500">
                  <!-- Heroicon name: outline/shield-check -->
                  <svg class="mr-4 h-6 w-6 text-cyan-100" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                  </svg>
                  Novedades
                </a>
                <a href="/login" class="group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md text-cyan-100 hover:text-white hover:bg-cyan-500">
                  <!-- Heroicon name: outline/shield-check -->
                  <svg class="mr-4 h-5 w-5 text-cyan-100" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" viewBox="0 0 512 512">
                    <path fill="currentColor" d="M160 96c17.7 0 32-14.3 32-32s-14.3-32-32-32H96C43 32 0 75 0 128V384c0 53 43 96 96 96h64c17.7 0 32-14.3 32-32s-14.3-32-32-32H96c-17.7 0-32-14.3-32-32l0-256c0-17.7 14.3-32 32-32h64zM504.5 273.4c4.8-4.5 7.5-10.8 7.5-17.4s-2.7-12.9-7.5-17.4l-144-136c-7-6.6-17.2-8.4-26-4.6s-14.5 12.5-14.5 22v72H192c-17.7 0-32 14.3-32 32l0 64c0 17.7 14.3 32 32 32H320v72c0 9.6 5.7 18.2 14.5 22s19 2 26-4.6l144-136z"/>
                  </svg>
                  Salir
                </a>
              </div>
            </div>
          </nav>
        </div>
      </div>

      <div class="fixed bottom-0 left-0 w-full hidden z-30">
        <div class="w-full py-2 bg-white border-t inline-flex items-center relative">
          <a href="/calendars" class="absolute h-12 w-12 top-0 rounded-full bg-cyan-200 text-cyan-800 shadow-lg inline-flex items-center left-1/2 transform -translate-x-1/2 -translate-y-1/2 ">
            <svg class="flex-shrink-0 h-5 w-5 mx-auto" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 448 512">
              <path d="M128 0c17.7 0 32 14.3 32 32V64H288V32c0-17.7 14.3-32 32-32s32 14.3 32 32V64h48c26.5 0 48 21.5 48 48v48H0V112C0 85.5 21.5 64 48 64H96V32c0-17.7 14.3-32 32-32zM0 192H448V464c0 26.5-21.5 48-48 48H48c-26.5 0-48-21.5-48-48V192zm64 80v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V272c0-8.8-7.2-16-16-16H80c-8.8 0-16 7.2-16 16zm128 0v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V272c0-8.8-7.2-16-16-16H208c-8.8 0-16 7.2-16 16zm144-16c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V272c0-8.8-7.2-16-16-16H336zM64 400v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V400c0-8.8-7.2-16-16-16H80c-8.8 0-16 7.2-16 16zm144-16c-8.8 0-16 7.2-16 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V400c0-8.8-7.2-16-16-16H208zm112 16v32c0 8.8 7.2 16 16 16h32c8.8 0 16-7.2 16-16V400c0-8.8-7.2-16-16-16H336c-8.8 0-16 7.2-16 16z"/>
            </svg>
          </a>
          <div class="w-1/4 inline-flex items-center">
              <a href="/home" class="text-slate-500 mx-auto">
                <div class="w-full flex">
                  <svg class="mx-auto flex-shrink-0 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                  </svg>
                </div>
                <label class="text-xs">Inicio</label>
              </a>
          </div>

          <div class="w-1/4 inline-flex items-center">
              <a href="/patients" class="text-slate-500 mx-auto">
                <div class="w-full flex">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" class="mx-auto flex-shrink-0 h-5 w-5" fill="currentColor">
                    <path d="M112 48a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm40 304V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V256.9L59.4 304.5c-9.1 15.1-28.8 20-43.9 10.9s-20-28.8-10.9-43.9l58.3-97c17.4-28.9 48.6-46.6 82.3-46.6h29.7c33.7 0 64.9 17.7 82.3 46.6l58.3 97c9.1 15.1 4.2 34.8-10.9 43.9s-34.8 4.2-43.9-10.9L232 256.9V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V352H152z"/>
                  </svg>
                </div>
                <label class="text-xs">Pacientes</label>
              </a>
          </div>

          <div class="w-1/4 inline-flex items-center">
              <a href="/profile" class="text-slate-500 mx-auto">
                <div class="w-full flex">
                  <svg class="mx-auto flex-shrink-0 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 512 512">
                    <path d="M399 384.2C376.9 345.8 335.4 320 288 320H224c-47.4 0-88.9 25.8-111 64.2c35.2 39.2 86.2 63.8 143 63.8s107.8-24.7 143-63.8zM0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256zm256 16a72 72 0 1 0 0-144 72 72 0 1 0 0 144z"/>
                  </svg>
                </div>
                <label class="text-xs">Perfil</label>
              </a>
          </div>

          <div class="w-1/4 inline-flex items-center">
              <a href="/more"class="text-slate-500 mx-auto">
                <div class="w-full flex">
                  <svg class="mx-auto flex-shrink-0 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 448 512">
                    <path d="M0 96C0 78.3 14.3 64 32 64H416c17.7 0 32 14.3 32 32s-14.3 32-32 32H32C14.3 128 0 113.7 0 96zM0 256c0-17.7 14.3-32 32-32H416c17.7 0 32 14.3 32 32s-14.3 32-32 32H32c-17.7 0-32-14.3-32-32zM448 416c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32s14.3-32 32-32H416c17.7 0 32 14.3 32 32z"/>
                  </svg>
                </div>
                <label class="text-xs">Mas</label>
              </a>
          </div>
        </div>
      </div>


      <div class="inline-block relative h-0 w-0">
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-slate-100 text-slate-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-gray-100 text-gray-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-zinc-100 text-zinc-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-neutral-100 text-neutral-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-red-100 text-red-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-orange-100 text-orange-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-amber-100 text-amber-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-yellow-100 text-yellow-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-lime-100 text-lime-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-green-100 text-green-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-emerald-100 text-emerald-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-teal-100 text-teal-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-cyan-100 text-cyan-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-cyan-100 text-cyan-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-indigo-100 text-indigo-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-violet-100 text-violet-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-purple-100 text-purple-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-fuchsia-100 text-fuchsia-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-pink-100 text-pink-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-rose-100 text-rose-100 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-slate-800 text-slate-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-gray-800 text-gray-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-zinc-800 text-zinc-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-neutral-800 text-neutral-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-red-800 text-red-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-orange-800 text-orange-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-amber-800 text-amber-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-yellow-800 text-yellow-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-lime-800 text-lime-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-green-800 text-green-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-emerald-800 text-emerald-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-teal-800 text-teal-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-cyan-800 text-cyan-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-cyan-800 text-cyan-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-indigo-800 text-indigo-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-violet-800 text-violet-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-purple-800 text-purple-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-fuchsia-800 text-fuchsia-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-pink-800 text-pink-800 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-rose-800 text-rose-800 m-1"></div>

          <div class="fixed p-1 top-0 left-0 -mt-8 bg-slate-500 text-slate-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-gray-500 text-gray-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-zinc-500 text-zinc-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-neutral-500 text-neutral-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-red-500 text-red-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-orange-500 text-orange-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-amber-500 text-amber-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-yellow-500 text-yellow-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-lime-500 text-lime-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-green-500 text-green-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-emerald-500 text-emerald-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-teal-500 text-teal-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-cyan-500 text-cyan-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-cyan-500 text-cyan-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-indigo-500 text-indigo-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-violet-500 text-violet-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-purple-500 text-purple-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-fuchsia-500 text-fuchsia-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-pink-500 text-pink-500 m-1"></div>
          <div class="fixed p-1 top-0 left-0 -mt-8 bg-rose-500 text-rose-500 m-1"></div>
        </div>


    </div>
    """
  end

  def mount(socket) do
    {:ok, assign(socket, sections: sections(0))}
  end

  def update(attrs, socket) do
    {:ok, assign(socket, sections: sections(attrs.section_id))}
  end

  defp sections(id) do
    [
      %{
        id: 1,
        name: "Home",
        url: "/",
        svg: """
        <svg class="mr-4 flex-shrink-0 h-6 w-6 text-cyan-100" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
        </svg>
        """
      },
      %{
        id: 2,
        name: "Productos",
        url: "/products",
        svg: """
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="h-6 w-6 text-cyan-100 mr-4" fill="currentColor">
            <path d="M256 48c0-26.5 21.5-48 48-48H592c26.5 0 48 21.5 48 48V464c0 26.5-21.5 48-48 48H381.3c1.8-5 2.7-10.4 2.7-16V253.3c18.6-6.6 32-24.4 32-45.3V176c0-26.5-21.5-48-48-48H256V48zM571.3 347.3c6.2-6.2 6.2-16.4 0-22.6l-64-64c-6.2-6.2-16.4-6.2-22.6 0l-64 64c-6.2 6.2-6.2 16.4 0 22.6s16.4 6.2 22.6 0L480 310.6V432c0 8.8 7.2 16 16 16s16-7.2 16-16V310.6l36.7 36.7c6.2 6.2 16.4 6.2 22.6 0zM0 176c0-8.8 7.2-16 16-16H368c8.8 0 16 7.2 16 16v32c0 8.8-7.2 16-16 16H16c-8.8 0-16-7.2-16-16V176zm352 80V480c0 17.7-14.3 32-32 32H64c-17.7 0-32-14.3-32-32V256H352zM144 320c-8.8 0-16 7.2-16 16s7.2 16 16 16h96c8.8 0 16-7.2 16-16s-7.2-16-16-16H144z"/>
          </svg>
        """
      },
      %{
        id: 3,
        name: "Usuarios",
        url: "/users",
        svg: """
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="h-6 w-6 text-cyan-100 mr-4" fill="currentColor">
            <path d="M224 256c70.7 0 128-57.3 128-128S294.7 0 224 0S96 57.3 96 128s57.3 128 128 128zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"/>
          </svg>
        """
      },
      %{
        id: 4,
        name: "Roles",
        url: "/roles",
        svg: """
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" class="h-6 w-6 text-cyan-100 mr-4" fill="currentColor">
            <path d="M64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H512c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64zm80 256h64c44.2 0 80 35.8 80 80c0 8.8-7.2 16-16 16H80c-8.8 0-16-7.2-16-16c0-44.2 35.8-80 80-80zm96-96c0 35.3-28.7 64-64 64s-64-28.7-64-64s28.7-64 64-64s64 28.7 64 64zm128-32H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16zm0 64H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16zm0 64H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16z"/>
          </svg>
        """
      },
      %{
        id: 5,
        name: "Facturación",
        url: "/invoices",
        svg: """
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" class="h-6 w-6 text-cyan-100 mr-4" fill="currentColor">
          <path d="M64 0C28.7 0 0 28.7 0 64V448c0 35.3 28.7 64 64 64H320c35.3 0 64-28.7 64-64V160H256c-17.7 0-32-14.3-32-32V0H64zM256 0V128H384L256 0zM64 80c0-8.8 7.2-16 16-16h64c8.8 0 16 7.2 16 16s-7.2 16-16 16H80c-8.8 0-16-7.2-16-16zm0 64c0-8.8 7.2-16 16-16h64c8.8 0 16 7.2 16 16s-7.2 16-16 16H80c-8.8 0-16-7.2-16-16zm128 72c8.8 0 16 7.2 16 16v17.3c8.5 1.2 16.7 3.1 24.1 5.1c8.5 2.3 13.6 11 11.3 19.6s-11 13.6-19.6 11.3c-11.1-3-22-5.2-32.1-5.3c-8.4-.1-17.4 1.8-23.6 5.5c-5.7 3.4-8.1 7.3-8.1 12.8c0 3.7 1.3 6.5 7.3 10.1c6.9 4.1 16.6 7.1 29.2 10.9l.5 .1 0 0 0 0c11.3 3.4 25.3 7.6 36.3 14.6c12.1 7.6 22.4 19.7 22.7 38.2c.3 19.3-9.6 33.3-22.9 41.6c-7.7 4.8-16.4 7.6-25.1 9.1V440c0 8.8-7.2 16-16 16s-16-7.2-16-16V422.2c-11.2-2.1-21.7-5.7-30.9-8.9l0 0c-2.1-.7-4.2-1.4-6.2-2.1c-8.4-2.8-12.9-11.9-10.1-20.2s11.9-12.9 20.2-10.1c2.5 .8 4.8 1.6 7.1 2.4l0 0 0 0 0 0c13.6 4.6 24.6 8.4 36.3 8.7c9.1 .3 17.9-1.7 23.7-5.3c5.1-3.2 7.9-7.3 7.8-14c-.1-4.6-1.8-7.8-7.7-11.6c-6.8-4.3-16.5-7.4-29-11.2l-1.6-.5 0 0c-11-3.3-24.3-7.3-34.8-13.7c-12-7.2-22.6-18.9-22.7-37.3c-.1-19.4 10.8-32.8 23.8-40.5c7.5-4.4 15.8-7.2 24.1-8.7V232c0-8.8 7.2-16 16-16z"/>
        </svg>
        """
      }
    ]
    |> Enum.map(fn s ->
      s
      |> Map.put(
        :class,
        if(id == s.id,
          do: "bg-cyan-500 text-white",
          else: "text-cyan-100 hover:text-white hover:bg-cyan-500"
        ) <> " group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md"
      )
    end)
  end
end
