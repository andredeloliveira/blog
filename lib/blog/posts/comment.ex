defmodule Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.{Comment, Post}

  schema "comments" do
    field(:uuid, :string)
    field(:email, :string)
    field(:name, :string)
    field(:body, :string)
    belongs_to(:post, Post)
    timestamps()
  end

  @params ~w( email name body )a

  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, @params)
    |> validate_required([:email, :body])
    |> put_change(:uuid, Ecto.UUID.generate())
    |> validate_format(:email, ~r/@/)
    |> validate_length(:body, min: 1, max: 500)
    |> foreign_key_constraint(:post_id)
  end
end
