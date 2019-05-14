defmodule BlogWeb.SessionView do
  use BlogWeb, :view

  alias BlogWeb.{UserView, SessionView}

  def render("show.json", %{
        user: user,
        token: token
      }) do
    %{
      data: %{
        user: render_one(%{user: user}, SessionView, "user.json"),
        token: token
      }
    }
  end

  def render("user.json", %{session: %{user: user}}) do
    render_one(user, UserView, "user.json")
  end
end
