defmodule BlogWeb.PostView do
  use BlogWeb, :view
  alias BlogWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.uuid,
      title: post.title,
      slug: post.slug,
      short_text: post.short_text,
      body: post.body,
      tags: post.tags,
      updated_at: post.updated_at,
      inserted_at: post.inserted_at
    }
  end

end
