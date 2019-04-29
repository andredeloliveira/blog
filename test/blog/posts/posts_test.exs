defmodule Blog.PostsTest  do
  use Blog.DataCase
  import Blog.Factory
  alias Blog.Posts

  setup  do
    {:ok, post} = fixture(:post)
    %{post: post}
  end

  describe "create_post/1" do
    @tag :unit
    test "should create a post if data is valid" do
      attrs = build(:post)
      assert {:ok, post} = Posts.create_post(attrs)
      assert post.title == attrs.title
    end

    @tag :unit
    test "should not create a post if data is invalid" do
      attrs = %{ name: "oh man" }
      assert {:error, %Ecto.Changeset{} } = Posts.create_post(attrs)
    end
  end

  describe "get_post/1" do

    @tag :unit
    test "Should find a post if it exists", %{post: post} do
      assert {:ok, found_post} = Posts.get_post(post.uuid)
      assert post.title == found_post.title
    end

    @tag :unit
    test "Should return a message error if post does not exist" do
      assert {:error, :not_found, :post, "1234" } = Posts.get_post("1234")
    end

    @tag :unit
    test "Should return a message of not found if no id is passed" do
      assert {:error, :not_found, :post, nil} = Posts.get_post(nil)
    end

    @tag :unit
    test "Should delete a post when it exists", %{post: post} do
      assert {:ok, deleted_post} = Posts.delete_post(post)
      deleted_post_id = deleted_post.uuid
      assert {:error, :not_found, :post, deleted_post_id} = Posts.get_post(post.uuid)
    end

    @tag :unit
    test "Should not delete a post if it does not exist" do
      assert {:error, :not_found, :post, nil} = Posts.delete_post(nil)
    end
  end

end
