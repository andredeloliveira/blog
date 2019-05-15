defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:hashed_password, :string)
    field(:permissions, :map)
    field(:username, :string)
    field(:password, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :hashed_password, :permissions])
    |> put_hashed_password()
    |> validate_required([:username, :hashed_password, :permissions])
    |> unique_constraint(:username)
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
