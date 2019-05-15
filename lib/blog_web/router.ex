defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :authenticated do
    plug(BlogWeb.Plug.AuthAccessPipeline)
  end

  scope "/", BlogWeb do
    pipe_through(:api)

    scope "/auth" do
      post("/identity/callback", AuthenticationController, :identity_callback)
    end

    pipe_through(:authenticated)
    resources("/posts", PostController)
    resources("/users", UserController, except: [:new, :edit])
  end
end
