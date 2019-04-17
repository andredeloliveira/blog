defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :uuid, :string
      add :title, :string
      add :slug, :string
      add :short_text, :string, size: 120
      add :body, :string
      add :tags, :string
      timestamps()
    end
    create(unique_index(:posts, [:slug]))
    create(index(:posts, [:title]))
  end

end
