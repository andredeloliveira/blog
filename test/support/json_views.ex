defmodule Blog.JsonViews do
  # import Blog.Repo

  def json_view(entity, attrs, opts \\ %{})

  def json_view(_entity, nil, _opts), do: nil

  def json_view(entity, attrs, opts) do
    Map.merge(render(entity, attrs), opts)
  end

  def render(:post, post) do
    %{
      "id" => post.uuid,
      "title" => post.title,
      "slug" => post.slug,
      "short_text" => post.short_text,
      "body" => post.body,
      "tags" => post.tags,
      "updated_at" => NaiveDateTime.to_iso8601(post.updated_at),
      "inserted_at" => NaiveDateTime.to_iso8601(post.inserted_at)
    }
  end

end
