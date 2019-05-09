defmodule Blog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:uuid, :string)
      add(:email, :string)
      add(:hashed_password, :string)

      timestamps()
    end
  end
end
