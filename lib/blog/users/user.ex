defmodule Blog.User do
  use Ecto.Schema

  alias Blog.User
  import Ecto.Changeset

  schema "users" do
    field(:uuid, :string)
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)
    field(:hashed_password, :string)
    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_password(:password)
    |> validate_email(:email)
  end

  def register_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> put_change(:uuid, Ecto.UUID.generate())
    |> validate_password(:password)
    |> validate_email(:email)
  end

  defp validate_email(changeset, field) do
    changeset
    |> update_change(field, &String.downcase/1)
    |> update_change(field, &String.trim/1)
    |> update_change(field, &String.replace(&1, " ", ""))
    |> validate_format(field, ~r/\S+@\S+\.\S+/)
    |> unique_constraint(field)
  end

  defp validate_password(changeset, field) do
    changeset
    |> validate_required([field])
    |> validate_length(field, min: 5)
    |> hash_password(field)
    |> validate_confirmation(field, message: "does not match password!")
    |> put_change(:password_confirmation, nil)
  end

  defp hash_password(%{valid?: false} = changeset, _field), do: changeset

  defp hash_password(%{valid?: true} = changeset, field) do
    hashed_password =
      changeset
      |> get_field(field)
      |> Bcrypt.hash_pwd_salt()

    changeset
    |> put_change(:password, nil)
    |> put_change(:hashed_password, hashed_password)
  end
end
