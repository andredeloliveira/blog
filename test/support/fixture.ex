defmodule Blog.Fixture do
  import Blog.Factory

  alias Blog.{Posts, Users}

  def fixture(entity), do: fixture(entity, %{})

  def fixture(:post, attrs) do
    :post
    |> build(attrs)
    |> Posts.create_post()
  end

  def fixture(:user, attrs) do
    :user
    |> build(attrs)
    |> Users.create_user()
  end
end
