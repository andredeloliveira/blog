defmodule BlogWeb.PostController do
  use BlogWeb, :controller
  alias Blog.{Post, Posts}

  action_fallback(BlogWeb.FallbackController)

  def index(conn, _) do
    posts = Posts.get_all_posts()
    render(conn, "index.json", posts: posts)
  end

  def show(conn, %{"id" => id} = _params) do
    with {:ok, post} <- Posts.get_post(id) do
      render(conn, "show.json", post: post)
    end
  end

  def create(conn, %{"post" => params}) do
    # I have to create something here to give permission to me or not.. but for now, we just add for the sake of having something
    with {:ok, post} <- Posts.create_post(params) do
      conn
      |> put_status(:created)
      |> render("show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, post} <- Posts.get_post_by(uuid: id),
         {:ok, %Post{}} <- Posts.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end

  def update(conn, %{"id" => id, "post" => params}) do
    with {:ok, post} <- Posts.get_post_by(uuid: id),
         {:ok, %Post{} = updated_post} <- Posts.edit_post(post, params) do
      render(conn, "show.json", post: updated_post)
    end
  end
end
