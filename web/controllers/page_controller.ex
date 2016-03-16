defmodule Spectacular.PageController do
  use Spectacular.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
