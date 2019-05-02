defmodule Blog.PostControllerTest do
  use BlogWeb.ConnCase

  alias Blog.{Post, Posts}

  setup %{conn: conn} do
    {:ok, post} = fixture(:post)

    conn =
      conn
      |> put_req_header("accept", "application/json")

    {:ok, conn: conn, post: post}
  end

  describe "index/2" do
    @tag :web
    test "Should show all posts", %{conn: conn} do
      conn = get(build_conn(), post_path(conn, :index))
      assert json_response(conn, 200)["data"]
      posts = json_response(conn, 200)["data"]
      assert length(posts) == 1
    end
  end

  describe "show/2" do
    @tag :web
    test "Should render a post", %{conn: conn, post: post} do
      conn = get(build_conn(), post_path(conn, :show, post.uuid))
      assert json_response(conn, 200)["data"] == json_view(:post, post)
    end
  end

  describe "create/2" do
    @tag :web
    test "should create a post with correct params" do
      attrs = build(:post)
      conn = post(build_conn(), post_path(build_conn(), :create, post: attrs))
      assert post_id = json_response(conn, 201)["data"]["id"]
    end
  end

  describe "delete/2" do
    @tag :web
    test "should delete a post", %{conn: conn, post: post} do
      conn = delete(conn, post_path(conn, :delete, post))
      assert response(conn, 204)
      assert [] = Posts.get_all_posts()
    end
  end
end
