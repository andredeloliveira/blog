defmodule Blog.Repo.Migrations.CreateComments do
  use Ecto.Migration
  def change do
    create table(:comments) do
      add :uuid, :string
      add :email, :string
      add :name, :string
      add :body, :string
      add :post_id, references(:posts)
      timestamps()
    end
    create(index(:comments, [:uuid]))
  end

end
