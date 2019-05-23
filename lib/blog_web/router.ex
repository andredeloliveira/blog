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

    resources("/posts", PostController, except: [:create, :delete])
    pipe_through(:authenticated)
    post("/posts", PostController, :create)
    put("/posts", PostController, :update)
    resources("/users", UserController, except: [:new, :edit])
  end
end
