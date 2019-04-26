defmodule Blog.Posts  do
  import Ecto.Query, warn: false
  alias Blog.Repo
  alias Blog.{Post}

  def create_post(attrs) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def get_post(nil) do
    {:error, :not_found, :post, nil}
  end

  def get_post(id) do
    from(
      p in Post,
      where: p.uuid == ^id,
      preload: [:comments]
    )
    |> Repo.one()
    |> case do
      %Post{} = post -> {:ok, post}
      nil -> {:error, :not_found, :post, id}
    end
  end

end
