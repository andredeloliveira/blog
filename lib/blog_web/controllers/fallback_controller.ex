defmodule BlogWeb.FallbackController do
  use BlogWeb, :controller
  alias BlogWeb.ChangesetView
  alias BlogWeb.ErrorView

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, _field, %Ecto.Changeset{} = changeset, _attrs}) do
    call(conn, {:error, changeset})
  end

  def call(conn, {:error, :not_found, resource, id}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404", %{resource: resource, id: id})
  end

  def call(conn, {:error, _field, :not_found, _changeset}) do
    call(conn, {:error, :not_found})
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :invalid_credentials}) do
    conn
    |> put_status(401)
    |> put_view(ErrorView)
    |> render(:invalid_credentials)
  end

  def call(conn, {:error, :invalid_password}) do
    conn
    |> put_status(422)
    |> put_view(ErrorView)
    |> render(:invalid_password)
  end

  def call(conn, {:error, :unauthenticated}) do
    conn
    |> put_status(401)
    |> put_view(ErrorView)
    |> render(:"401")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:forbidden)
    |> put_view(ErrorView)
    |> render(:"403")
  end

  def call(conn, {:error, _error}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end
end
