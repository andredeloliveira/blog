defmodule BlogWeb.UserController do
  use BlogWeb, :controller

  alias BlogWeb.Authenticator
  alias Blog.{Users}

  action_fallback(BlogWeb.FallbackController)

  def show(conn, %{"id" => id} = _params) do
    with {:ok, user} <- Users.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def create(conn, %{"user" => params}) do
    with {:ok, user} <- Users.create_user(params),
         conn <- Authenticator.login(conn, user),
         token <- Authenticator.current_token(conn) do
      conn
      |> put_status(:created)
      |> put_view(SessionView)
      |> render("show.json", user: user, token: token)
    end
  end
end
