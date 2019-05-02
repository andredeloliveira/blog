defmodule Blog.Posts do
  import Ecto.Query, warn: false
  alias Blog.Repo
  alias Blog.{Post}

  def create_post(attrs) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def get_all_posts do
    from(p in Post, select: p)
    |> Repo.all()
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

  def get_post_by(attrs) do
    case Repo.get_by(Post, attrs) do
      %Post{} = post -> {:ok, post}
      nil -> {:error, :not_found, :post, attrs}
    end
  end

  def delete_post(%Post{} = post) do
    post
    |> Repo.delete()
  end
end
