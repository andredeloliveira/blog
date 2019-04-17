defmodule Blog.Post do
  use Ecto.Schema
  # use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Blog.Post

  schema "posts" do
    field(:uuid, :string)
    field(:title, :string)
    field(:slug, :string)
    field(:short_text, :string)
    field(:body, :string)
    field(:tags, :string)
    timestamps()
  end

  @params ~w( uuid title slug short_text body tags )a
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, @params)
    |> validate_required([:title, :short_text, :body, :tags])
    |> put_change(:uuid, Ecto.UUID.generate())
    |> put_change(:slug, Ecto.UUID.generate())
    |> unique_constraint(:uuid)
  end

end
