defmodule Blog.Fixture do
  import Blog.Factory

  alias Blog.{Posts}

  def fixture(entity), do: fixture(entity, %{})

  def fixture(:post, attrs) do
    :post
    |> build(attrs)
    |> Posts.create_post()
  end
end
