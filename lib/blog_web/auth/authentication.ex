defmodule BlogWeb.Guardian do
  use Guardian, otp_app: :blog

  alias Blog.User

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    # resource = Blog.{:ok, resource}
  end
end
