defmodule GarcWeb.PageController do
  use GarcWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
