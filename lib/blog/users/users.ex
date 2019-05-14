defmodule Blog.Users do
  import Ecto.Query, warn: false
  alias Blog.Repo
  alias Blog.User

  def create_user(attrs) do
    %User{}
    |> User.register_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(email, password) do
    from(u in User, where: u.email == ^email)
    |> Repo.one()
    |> check_password(password)
  end

  def get_user(id) do
    from(u in User,
      where: u.uuid == ^id
    )
    |> Repo.one()
    |> case do
      %User{} = user -> {:ok, user}
      nil -> {:error, :not_found, :user, id}
    end
  end

  defp check_password(nil, _), do: {:error, "Incorrect email or password"}

  defp check_password(user, password) do
    case Bcrypt.verify_pass(password, user.hashed_password) do
      true -> {:ok, user}
      false -> {:error, "Incorrect email or password"}
    end
  end
end
