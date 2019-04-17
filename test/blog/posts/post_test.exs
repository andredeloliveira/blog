defmodule Blog.PostTest do
  use Blog.DataCase
  import Blog.Factory

  alias Blog.Post

  describe "changeset/2" do

    @tag :unit
    test "should be valid if params are for post correct" do
      attrs = build(:post)
      post = Post.changeset(%Post{}, attrs)
      assert post.valid?
    end

  end
end
